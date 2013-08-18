---
author: David
comments: false
date: 2008-05-29 15:31:26+00:00
layout: post
slug: rspec-waving-bye-bye-to-implicit-module-inclusion
title: RSpec waving 'bye bye' to implicit module inclusion
wordpress_id: 65
---

Until sometime very soon, when you describe a module in RSpec using this syntax:





    
    describe SomeModule do
    ...
    end
    





RSpec implicitly includes that module in the example group. This allows you to do this:





    
    describe CatLikeBehaviour do
    it "should say 'meow' when it greets you" do
      say_hello.should == 'meow'
    end
    end
    
    module CatLikeBehaviour do
    def say_hello
      'meow'
    end
    end
    





As is often the case with things implicit, this actually turns out to be a problem. The problem revealed itself most notably when an RSpec user reported that a `describe()` method in a module he was using was conflicting with RSpec's `describe()` method.






One response to that thread suggested that using `describe()` in a module might be too generic, but I think that really hides the point. Imagine how frustrated you would get if you had examples of a module with a `current?` method and we decided to add a `current?` method to `Spec::Example::ExampleGroupMethods`. You'd suddenly start seeing those examples fail with stack traces eminating from RSpec instead of your code. Not good.






And so, we are going to be removing this feature.






With the 1.1.4 release, you get a warning any time that the example calls a method on `self` that is part of the included module. Soon it will be removed entirely.






### rails helper examples






The biggest impact of this is going to be felt in rspec-rails helper examples. There are two remedies that you have if you've got examples that send messages to `self` that should be going to another object:






1. use the new `helper` object provided by `HelperExampleGroup`





    
    describe DateHelper do
    it "should format the date as mm/dd/yyyy" do
      helper.format_date(Date.new(2008, 5, 31)).should == '05/31/2008'
    end
    end
    





The `helper` object is an instance of `ActionView::Base` with the named module included in it, so it has access to everything else that it should have.






2. include the module explicitly





    
    describe DateHelper do
    include DateHelper
    it "should format the date as mm/dd/yyyy" do
      format_date(Date.new(2008, 5, 31)).should == '05/31/2008'
    end
    end
    





My recommendation is definitely the first option as I find it more expressive.






I realize this is API changing and backward-compatibility breaking, but this is one of those cases where, at least in my view, the pain is justified by the result.
