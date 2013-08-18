---
author: David
comments: false
date: 2009-01-13 08:55:00+00:00
layout: post
slug: rspec-1-1-12-is-released
title: rspec-1.1.12 is released
wordpress_id: 2020
---

We just released rspec-1.1.12. You can read the changelogs for [rspec](http://rspec.info/documentation/changes-rspec.html) and [rspec-rails](http://rspec.info/rails/changes-rspec-rails.html) for all the details, but are some changes that you should definitely know about.

### Cucumber is the new Story Runner

rspec-1.1.12 is the last release that will ship with the Story Runner bundled. With the next release, we will do the one and only gem release of [repo](http://github.com/dchelimsky/rspec-stories,) so you won't be forced to upgrade to [Cucumber](http://github.com/aslakhellesoy/cucumber.git.) Thanks to [Chad Humphries](http://spicycode.com/) for stepping in and extracting the Story Runner to a separate repo.

The Story Runner is _deprecated_, however, and we will not be maintaining it. If anybody wants to maintain it, you're welcome to. Just fork the [repo](http://github.com/dchelimsky/rspec-stories) and have at it.

Why are we deprecating the Story Runner? Because [Aslak Hellesøy's](http://blog.aslakhellesoy.com) [Cucumber](http://github.com/aslakhellesoy/cucumber.git) library kicks its ass. Easier setup means lower barrier to entry, building on treetop means great feedback with backtraces plus support for an ever-growing list of written languages. And [migrating from RSpec Stories](http://wiki.github.com/aslakhellesoy/cucumber/migration-from-rspec-stories) is a snap. So what are you waiting for?


<!-- more -->### Rails 1.2.6 will no longer be supported by new versions of rspec

rspec-rails-1.1.12 is the last rspec release that will support pre-2.0 releases of Rails. For anybody interested in maintaining rspec-rails for rails-1.2.6, I've created a [1.1-maintenance](http://github.com/dchelimsky/rspec-rails/tree/1.1-maintenance) branch, which you are welcome to fork and go nuts. There is also a [1.1-maintenance](http://github.com/dchelimsky/rspec/tree/1.1-maintenance) branch for rspec, so you'd be working from a matched pair.


So that's what's going away. Here's what's new!


### it { should provide\_an\_implicit_subject }


Ever write a code example like this?


    
    
    describe Person do
    it "should validate presence of email" do
      person = Person.new(:email =>; nil)
      person.should_not be_valid
      person.should have(1).error_on(:email)
    end
    end
    



That comes up pretty often in rails apps when spec'ing out models. There are a few matcher libraries out there like [rspec-on-rails-matchers](http://github.com/joshknowles/rspec-on-rails-matchers) that provide matchers like this validate_presence_of(:email), which let you reduce the previous example to this:


    
    
    describe Person do
    it "should validate presence email" do
      Person.new.should validate_presence_of(:email)
    end
    end
    



Of course, the next step is to want to get rid of the redundancy between the docstring passed to #it and the matcher, so you end up with this:


    
    
    describe Person do
    it do
      Person.new.should validate_presence_of(:email)
    end
    end
    



Do it? Ugh! This has always driven me nuts when I see `it do`, so I'd make that this:


    
    
    describe Person do
    it { Person.new.should validate_presence_of(:email) }
    end
    



Well, thanks to a contribution from [Joe Ferris](http://www.thoughtbot.com/about/people) from thoughtbot, we now have an implicit subject in our specs, so you can do this:


    
    
    describe Person do
    it { should validate_presence_of(:email) }
    end
    



w00t! Now _that_ is concise. [Brandon Keepers wrote about this a while back](http://opensoul.org/2008/11/10/making-rspec-concise/), but this feature hadn't actually been released until rspec-1.1.12.

### it { should handle\_slightly\_more\_complex\_conditions }


The implicit subject feature works by creating a new instance of the class passed to describe for each example. In the last example above, when the example receives the #should message, it delegates it to a new instance of Person. That's fine for a lot of cases, but sometimes we'll need a bit more context than simply calling new. For those situations, you can create your own subject for an example group like this:




    
    
    describe Person do
    describe "born 19 years ago" do
      subject { Person.new(:birthdate => 19.years.ago }
      it { should be_eligible_to_vote }
      it { should be_eligible_to_enlist }
      it { should_not be_eligible_to_drink }
    end
    end
    



Happy Spec'ing, and Happy New Year!
