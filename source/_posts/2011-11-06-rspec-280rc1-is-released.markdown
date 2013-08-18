---
author: David
comments: true
date: 2011-11-06 17:02:40+00:00
layout: post
slug: rspec-280rc1-is-released
title: rspec-2.8.0.rc1 is released
wordpress_id: 2845
categories:
- BDD
- RSpec
- Ruby
---

I just released rspec-2.8.0.rc1, which includes releases of rspec-core,
rspec-expectations, rspec-mocks, and rspec-rails. Changelogs for each are at:

* [rspec-core](https://github.com/rspec/rspec-core/blob/master/Changelog.md)
* [rspec-expectations](https://github.com/rspec/rspec-expectations/blob/master/Changelog.md)
* [rspec-mocks](https://github.com/rspec/rspec-mocks/blob/master/Changelog.md)
* [rspec-rails](https://github.com/rspec/rspec-rails/blob/master/Changelog.md)

## What's new

Nothing really changed in rspec-rails or rspec-mocks, but rspec-core and
rspec-expectations have both gotten some nice improvements.

### Configuration (rspec-core)

rspec-core offers a number of configuration options which can be declared on
the command line, in a config file (`.rspec`, `~/.rspec`, or custom location),
as well as in an `RSpec.configure` block (in `spec/spec_helper.rb` by
convention). Before this release, some options, but not all, could be stored in
config files and then overridden on the command line. The problems were that it
was inconsistent (not all options worked this way), and we couldn't override
options that were set in `RSpec.configure` blocks.

With this release, almost all options declared in `RSpec.configure` can be
overridden from the command line, and `--tag` options can override their
inverses. For example, if you have this in `.rspec`:


    
    
    --tag ~slow:true
    



That means "exclude examples tagged `:slow => true`". So the following example
would be excluded:


    
    
    it "does something", :slow => true do
      # ...
    end
    



You can also exclude that example from `RSpec.configure` like this:


    
    
    RSpec.configure do |c|
      c.filter_run_excluding :slow => true
    end
    



Note: the naming is different for historical reasons, and we will reconcile
that in a future release, but for now, just know that `--tag` on the command
line and in `.rspec` is synonymous with `filter_run_[including|excluding]` in
`RSpec.configure`.

### Override from command line

Whether the default is stored in `.rspec` or `RSpec.configure`, it can be overridden
from the command line like this:


    
    
    rspec --tag slow:true
    



### "Profiles" in custom options files

The `rspec` command has an `--options` option that let's store command line args in
arbitrary files and tell RSpec where to find them. For example, you could set things
up so your normal spec run excludes the groups and examples marked `:slow` by putting
this in `.rspec`:


    
    
    --tag ~slow
    



Now add a `.slow` file with:


    
    
    --tag slow
    



Now run `rspec` to run everything but the slow specs, and run `rspec --options
.slow` or `rspec -O.slow` to run the slow ones.

### Override from Rake task

RSpec's Rake task supports an `rspec_opts` config option, which means you can
set up different groupings from rake tasks as well. The fast/slow example above
would look like this:


    
    
    namespace :spec do
      desc "runs the fast specs"
      RSpec::Core::RakeTask.new(:fast) do |t|
        t.rspec_opts = '--options .fast'
      end
      RSpec::Core::RakeTask.new(:slow) do |t|
        t.rspec_opts = '--options .slow'
      end
    end
    



Or ..


    
    
    namespace :spec do
      desc "runs the fast specs"
      RSpec::Core::RakeTask.new(:fast) do |t|
        t.rspec_opts = '--tag ~slow'
      end
      RSpec::Core::RakeTask.new(:slow) do |t|
        t.rspec_opts = '--tag slow'
      end
    end
    



### Implicit `true` value for tags/filters

This is not new in rspec-2.8, but all the tags/filters in the example above can
be written without explicitly typing `true`:


    
    
    --tag slow
    --tag ~slow
    


    

    
    
    RSpec.configure {|c| c.filter_run_excluding :slow}
    
    it "does something", :slow do
    



You have to set a config option to enable this in rspec-2.x:


    
    
    RSpec.configure {|c| c.treat_symbols_as_metadata_keys_with_true_values = true}
    



In rspec-3.0, this will be the default, but without setting this value in 2.x
you'll get a deprecation warning when you try to configure things this way.
It's ugly, I know, but this enabled us to introduce the new behavior without
breaking compatibility with some suites in a minor release.

### Ordering

With 2.8, you can now run the examples in random order, using the new `--order`
option:


    
    
    --order rand
    



The order is randomized with some reasonable caveats:

* top level example groups are randomized
* nested groups are randomized within their parent group
* examples are randomized within their group

This provides a very useful level of randomization while maintaining the
integrity of before/after `hooks`, `subject`, `let`, etc.

If you want to run the examples in the default ordering (file-system load
order for files and declaration order for groups/examples), you can override
the order from the command line:


    
    
    --order default
    



### Pseudo-randomization

The randomization is managed by Ruby's pseudo-randomization. This means that if
you find an order dependency and want to debug/fix it, you can fix the order by
providing the same seed for each run:


    
    
    --order rand:1234
    



The seed is printed to the console with each run, so you can just copy it to the
command. You can also just specify the seed, which RSpec will assume means you want
to run with `--order rand`:


    
    
    --seed 1234
    



Every time you run the suite with the same seed, the examples will run in the
same "random" order.

### Built-in matchers are all classes in rspec-expectations

The [Matcher
DSL](http://rubydoc.info/github/rspec/rspec-expectations/master/RSpec/Matchers)
in rspec-expectations makes it dead simple to define custom matchers that suit
your domain. The problem is that it is [several times slower than defining a
class to do
so](https://github.com/rspec/rspec-expectations/blob/master/benchmarks/matcher_dsl_vs_classes.rb).
While this doesn't make much difference when you have a custom matcher that you
use a few dozen times (where talking hundredths of seconds here), it does make
a difference if every single matcher invocation in your entire suite suffers
this problem.

The short term fix is that all of the built-in matchers have been
re-implemented as classes rather than using the DSL to declare them. This has
the added benefit of making it easier to navigate the code and RDoc

Longer term, we'll try to refactor the internals of the matcher DSL so that it
generates a class at declaration time. Eventually.

### Summing up

So that's it. Nothing ground breaking. Nothing compatibility
breaking. But some nice new features and improvements that will make your life
just a little bit nicer when you upgrade. We're doing a release candidate
because enough changed internally that I want to give you time to try it out,
so please, please do so! And please report any issues you're having with this
upgrade to:

* [rspec-core](https://github.com/rspec/rspec-core/issues)
* [rspec-expectations](https://github.com/rspec/rspec-expectations/issues)
* [rspec-mocks](https://github.com/rspec/rspec-mocks/issues)
* [rspec-rails](https://github.com/rspec/rspec-rails/issues)

Assuming there are no significant issues, I'll release 2.8 final within a week
or two.

Happy spec'ing!

David

