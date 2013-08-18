---
author: David
comments: true
date: 2010-01-25 03:31:02+00:00
layout: post
slug: rspec-20-in-the-works
title: Rspec 2.0 in the works
wordpress_id: 2609
categories:
- RSpec
---

We've started to do some preliminary work on rspec-2.0, which we plan to release before Rails-3 goes final. At that point, the rspec-rails-2.0 plugin/gem will only work with rspec >= 2.0 and rails >= 3.0.

We're committed to making the upgrade from rspec-1.x to rspec-2.0 as seamless as possible for most users, but extenders are going to see some differences. This is why we're going to take our time with alpha, beta, and candidate releases.

Here are some of the improvements you can expect:

### Modularity

Following the Rails and Merb models, Rspec-2 will be broken up into component gems and a meta-gem that depends on them. Most users will still `gem install rspec`, and doing so will install the component gems.

We've broken rspec up into 4 repos in the [rspec account on github](http://github.com/rspec):

* rspec => meta gem that depends on the others
* rspec-core => runner and output formatters
* rspec-expectations => `should` and matchers
* rspec-mocks => mocks and stubs

With separate component repos, you'll be able to use rspec as you do today or mix and match components with other frameworks. This will also make it easier for contributors to contribute to the components they are interested in without worrying about other components.

### New runner extracted from Micronaut

The [rspec-core](http://github.com/rspec/rspec-core) repository is a complete rewrite of the runner, which has been a big sore spot over the years for contributors and extenders. We extracted the runner from [Micronaut](http://github.com/spicycode/micronaut), which is an Rspec-compatible framework written by [Chad Humphries](http://github.com/spicycode).

Micronaut has a simple and powerful metadata model, which allows us to easily slice and dice a spec suite in much the same way we do now with Cucumber using tags. It also helps to simplify rspec's own specs (because you can access it from within an example).

Because we're able to intercept examples before they are run, we'll also be able to offer a clean extension API, allowing you to add structures like [Merb](http://merbivore.org/)'s `given` blocks without monkey patching. Less monkey patching `==` more maintainable.

### Where we are today

While Micronaut runs the same specs that Rspec does, there are some different names for things, and there are some differences in the CLI as well. We've started to resolve some of the differences in [rspec-core](http://github.com/rspec/rspec-core), but we have a way to go.

If you want to try it out and see what works and what doesn't, you can either install the prerelease gems (2.0.0.a2 as of this writing):


    
    [sudo] gem install rspec --prerelease



You can also grab the dev environment and have a look at the code. See the [rspec-dev README](http://github.com/rspec/rspec-dev) for info.

***Please do not start reporting issues yet as this will only slow us down.***

There is a lot that works, but there is also a lot that doesn't. Once we get to beta, we'll be looking for feedback and contributions, but for now we just want to let you know where things are.

Rspec 2 uses `Rspec` as the root namespace and installs an `rspec` command instead of a `spec` command. Until we release 2.0.0 final, this will make it easy for you to keep things separate on your system and in your apps. Once we go final we'll either alias the old names or release a separate backwards-compatibility wrapper gem that does this for you.

### What's next

We want to focus most of our efforts on rspec-2 at this point, so we don't plan any new development on the rspec-1.x series. We'll do bug-fix releases of rspec[-rails]-1.3, but no new features. 

I'll follow up with more information as it becomes clear. Look here for announcements about alpha and beta releases if you're interested in trying it out early or getting involved.

