---
author: David
comments: false
date: 2007-11-29 08:58:18+00:00
layout: post
slug: nested-example-groups
title: Nested Example Groups
wordpress_id: 49
---

Since rspec first appeared on the scene, users have been asking for nested example groups. Well it has finally arrived. RSpec 1.1.0 will ship with support for nesting, so you'll be able to do things like this:





    
    <code>
    describe RSpec do
    before(:each) do
      @rspec = RSpec.new
    end
    
    describe "at release 1.0.8" do
      before(:each) do
        @rspec.version = "1.0.8"
      end
    
      it "should not support nested example groups" do
        @rspec.should_not support_nested_example_groups
      end
    end
    
    describe "at release 1.1.0" do
      before(:each) do
        @rspec.version = "1.1.0"
      end
    
      it "should support nested example groups" do
        @rspec.should support_nested_example_groups
      end
    end
    end
    </code>





This will output:





    
    
    RSpec at release 1.0.8
    - should not support nested example groups
    
    RSpec at release 1.1.0
    - should support nested example groups
    





If you're using trunk, you can do this now with revision 3009 or later.






Happy nesting!
