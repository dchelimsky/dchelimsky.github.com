---
author: David
comments: true
date: 2011-05-28 22:03:57+00:00
layout: post
slug: rake-09-and-gem-version-constraints
title: rake 0.9 and gem version constraints
wordpress_id: 2799
categories:
- Ruby
---

There's been some confusion surrounding the rake-0.9.0 release, and I'd like to
take the opportunity to clarify some things and hopefully draw attention to gem
versioning policies and their implications for everybody in the Ruby community.

First, there are three distinct issues related to the rake release:

### 1. Backward-incompatibility

Rake 0.9 includes backward-incompatible changes. Per the
[changelog](https://github.com/jimweirich/rake/blob/master/CHANGES):

    ## Version 0.9.0

    * *Incompatible* *change*: Rake DSL commands ('task', 'file', etc.)  are
      no longer private methods in Object.  If you need to call 'task :xzy' inside
      your class, include Rake::DSL into the class.  The DSL is still available at
      the top level scope (via the top level object which extends Rake::DSL).

This conflicts with the way Rails, among others, uses Rake, among others.  The
workaround recommended by [@dhh](https://twitter.com/dhh) is to constrain the
rake version in the Gemfiles in your Rails applications:

    gem "rake", "0.8.7"

This is a perfectly fine short term solution to keep your applications running,
but it won't be long before a gem that your Rails application depends on,
either directly or through the transitive property of dependencies, is going to
specify any of:

    gemspec.add_dependency 'rake', '0.9.0'
    gemspec.add_dependency 'rake', '>= 0.9.0'
    gemspec.add_dependency 'rake', '~> 0.9.0'

When that happens, you'll need to loosen the constraint in your app if you want
to upgrade any of the gems downstream from the gem that introduces this
dependency. This is not a big deal because you can control the situation
directly in your own Gemfile in your own application.

### Libraries are not applications

This advice should _not_, however, be applied to any gems that depend on Rake.
Let's say you're using two gems that both provide Rake tasks and therefore
depend on the rake gem. At some point the maintainer of gem aaa changes the
constraint to `"= 0.8.7"`, and the maintainer of gem bbb keeps a looser
constraint: either `">= 0.8.7"` or `"~> 0.8.7"`. You upgrade to the new version
of aaa and everything is fine because both constraints are satisfied by
rake-0.8.7.

A little while down the road, the constraint in bbb changes to `"~> 0.9.0"`. At
this point you are unable to have the newest versions of aaa and bbb in the
same application. This may not seem like a big deal because you can choose to
not upgrade bbb at this point, but the further upstream the dependency (i.e.
aaa depends on bbb, which depends on ccc), the more likely you are to be
constrained in your upgrade choices.

In short, if you are maintaining a gem that applications or other gems depend
on, you are doing end users a disservice by locking down any upstream
dependency at one and only one version number. 

Now here's the catch: while some gem maintainers follow some sort of standard
versioning and/or release policy, there are many that don't.  If you put in a
looser version constraint on a gem whose maintainers introduce breaking changes
in patch releases, you are also doing your users a disservice. More on this
later.

### 2. Rake is used to run tasks that depend on Rake

Perhaps you've run into this interaction (or similar):

    $ bundle install
    $ rake db:migrate
    You have already activated rake 0.9.0, but your Gemfile requires rake 0.8.7. Consider using bundle exec.

In this case, the application has an explicit dependency on rake-0.8.7, but
rake-0.9.0 is installed in the shell environment. When you type `rake xxx`,
Rubygems activates the 0.9.0 version (the newest version installed), and then
tries to activate 0.8.7 when the app is running.

This is a catch 22 that we've been lulled into ignoring by the mere fact that
there have not been any rake releases for a couple of years (rake-0.9.0 was
released 2 years and 5 days after rake-0.8.7). We all expect to type `rake xxx`
and have it just work. Why not? It's worked thus far, right?

During the two years of rake-0.8.7, Bundler was born. You may remember that the
Bundler team took a lot of heat during its early days. One of the complaints I
remember was that people didn't want to have to type `bundle exec` to run a
rake task. The result is that pretty much all apps that use Bundler and Rake
have this in their Rakefiles:

    require 'rubygems'
    require 'bundler'
    Bundler.setup

This enables us to type `rake xxx` and let Bundler manage loading every other
gem besides rake, which is already loaded by Rubygems. So now when we find both
rake-0.8.7 and 0.9.0 in our gem environment, and the app we're working with depends
explicitly on 0.8.7, we have (at least) three options:

#### a. Tell bundler to install the rake command PROJECT_ROOT/bin

    bundle install --binstubs

Now you can run this

    bin/rake xxx

#### b. Explicitly run bundle exec

    bundle exec rake

In either of the first two options, Bundler controls the activation of the rake
gem for you, which allows it to put the correct version on the `$LOAD_PATH`.

#### c. Just remove 0.9 from the current gem environment

    gem uninstall rake

This only works if you're using an isolated gemset for the current project
(e.g. using rvm) or you simply don't need rake-0.9.0 on your system. It also is
not a very reliable way to deal with this if you have any sort of automated
build or deployment system that is installing gems into a shared gem
environment on the build or production servers.

The real problem here is not that we have to type a different command on the
command line. We humans can adapt and get used to doing that. The deeper
problem is that there are countless automation scripts out in the wild that
depend on `rake xxx`. In order to support both versions of Rake, they will all
have to be changed to use one of the first two solutions noted above. The cost
of this is no small chunk of change, but it is nobody's fault but our own for
failing to recognize the cyclical nature of using a versioned tool to run
applications that might require a different version.

### 3. Not all gems expose their dependencies in a way that Bundler or Rubygems can control them

On my team at DRW, we tried to constrain our rake dependencies to 0.8.7 as a
temporary measure, but each time we installed into a new gem environment we
found that rake-0.9.0 was being installed. It turned out that a gem we depended
on was installing rake through a back door, and with no version constraint at
all.  The result was that neither Bundler nor Rubygems had any control over
this installation relative to our application (Bundler told Rubygems to install
this gem, and this gem silently installed rake). And, to make things more
confusing, Bundler reported that it was installing rake-0.8.7 and said nothing
about 0.9.0.

The maintainer of that gem released new versions right away, so that issue is now
resolved, but it's entirely possible that other gems you're using are doing the
same (or similar). Just something to keep your eye out for.

### What can we learn from all of this?

One issue this exposes is a lack of common understanding and agreement about
how to manage releases and dependencies. The [Rubygems Rational
Versioning](http://docs.rubygems.org/read/chapter/7) policy and
[Semantic Versioning](http://semver.org) are both very sound approaches that share a common
scheme for version numbers:

A version has three parts: major, minor, and patch.  For example, release 3.0.0
is a major release because the first number was incremented from 2 to 3, 3.2.0
is a minor release because the second number was incremented from 1 to 2, and
3.2.1 is a patch release because the third number was incremented from 0 to 1.
Both specs state the following:

1. Patch releases (3.2.1) should only include bug fixes and internal implementation changes.
2. Minor releases (3.2.0) can include bug fixes, internal changes, and new features, but no breaking changes.
3. Major releases (3.0.0) can include bug fixes, internal changes, new features, and breaking changes.

If everybody adhered to either policy, we'd all be able to declare our gem dependencies like this:

    spec.add_dependency "foo", ">= 2.3", "< 3.0"

... or the following, oft misunderstood, shortcut for same:

    spec.add_dependency "foo", "~> 2.3"

This tells Rubygems to install the newest version that is >= 2.3.0, trusting
that no version 2.y.x will include breaking changes.

### RSpec

I'll confess that I didn't adhere to either approach with RSpec until the
rspec-2.0.0 release, last October. I knowingly introduced breaking changes in
the 1.x series and RSpec likely lost the confidence of a fair sum of users
during that time.

The good news, vis a vis RSpec, is that we've been following Rubygems Rational
Versioning since the rspec-2.0 release.  While we've had a couple of
regressions in the process (followed swiftly by patch releases that addressed
them), there has been only one intentionally breaking change, and that was
related to integration with another library. That change was announced,
documented, and I don't recall seeing any issues reported related to it.

We're not doing SemVer yet because it is more strict than RRV, and RSpec does
not currently meet all of its criteria. I do hope, however, to have RSpec on
SemVer before the year is out.

### This all sounds great, but ...

... the reality is that getting every gem developer to commit to RRV or SemVer
is very unlikely. What those of us who do _can_ do, however, is try to provide
a balance of flexibility and safety when we declare upstream dependencies. The
[rspec-expectations](https://rubygems.org/gems/rspec-expectations) gem, for
example, declares the following runtime dependency:

    diff-lcs ~> 1.1.2

This expresses an opinion that it is safe for your application (that depends on
rspec-expectations) to depend on any 1.1.x version of diff-lcs greater than or
equal to 1.1.2, but it is not safe to depend on 1.2.0.  While this provides a
high degree of safety, it also provides low flexibility: if any other gem your
app depends on depends on diff-lcs-1.2 in the future (not likely, since 1.1.2
was released in 2004, but that's besides the point), you won't be able to use
it with the current release of rspec-expectations, even if the diff-lcs-2.2
release does not include any breaking changes.

If diff-lcs was still under regular maintenance, and it's maintainers were
committed to RRV or SemVer, then rspec-expectations would be able to use this
dependency instead:

    diff-lcs ~> 1.2

This would provide significantly more flexibility in rspec-expectations's
ability to play nice with other gems that also depend on diff-lcs in the same
applciation over a longer period of time.

Note that every gem page on [rubygems.org](http://rubygems.org) now includes a
recommendation to use the pessamistic constraint using a three-part version
number (e.g. `rake ~> 0.9.0`). As just discussed, this provides safety, but
lacks long term flexibility.

### Depending on rake

So what should maintainers of gems that depend on rake do now? The likelihood
is that some end users will constrain their applications to rake `0.8.7`, and
others will constrain them to `= 0.9.0`, `~> 0.9.0`, or `>= 0.9.0`. Unless Jim
Weirich announces that rake will follow RRV or SemVer, we have to allow for the
possibility that rake `0.10.0` will introduce new breaking changes. In this
case, I think the responsible thing to do is make sure our gems work with both
rake-0.8 and 0.9, and specify the dependency like this:

    spec.add_runtime_dependency 'rake', '>= 0.8.7', '< 0.10'

Trusting that no rake 0.9.x version will introduce breaking changes, this
provides the greatest flexibility to end users without exposing them to the
risk of breaking changes in rake-0.10.0.

### Feedback

I'm curious to hear what you think about all of this. Do you think this all
makes sense?  Do you think I'm over or understating the importance, complexity,
or severity of these issues?  Do you have a different approach to recommend in
moving forward?  I look forward to your feedback.


