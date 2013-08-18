---
author: David
comments: false
date: 2007-03-01 15:56:40+00:00
layout: post
slug: spec-expectations-and-test-unit-testcase-together-again-at-last
title: Spec::Expectations and Test::Unit::TestCase, together again at last
wordpress_id: 20
---

In [Rob Sanheim](http://www.robsanheim.com/)'s blog [comparing test/spec w/ rspec](http://www.robsanheim.com/2006/12/29/bdd-in-rails-testspec-and-rspec/), Rob pointed out that he had "been following RSpec, the better known Ruby BDD library for awhile, but decided against it since it just doesn't look practical for use in an established project with around ~400 test cases."

As it turns out, rspec-0.8 has done a much better job of isolating components. It's not quite ideal yet, but it is sufficient to support using RSpec's expectations right in your Test::Unit::TestCases.
<!-- more -->

To make this happen, you need to require a few things:




    
    <code>require 'test/unit'
    require 'rubygems'
    gem 'rspec'
    require 'spec/expectations'
    require 'spec/matchers'</code>





'spec/expectations' adds #should and #should_not to your objects. 'spec/matchers' provides RSpec's Expression Matchers, which you then need to explicitly include in the TestCase:





    
    <code>class ThingTest < Test::Unit::TestCase
    include Spec::Matchers
    </code>





Here's an example with one passing and one failing test.





    
    <code>require 'test/unit'
    require 'rubygems'
    gem 'rspec'
    require 'spec/expectations'
    require 'spec/matchers'
    
    class ThingTest < Test::Unit::TestCase
    include Spec::Matchers
    
    def setup
      @thing = Thing.new
    end
    
    def test_should_have_4_subthings #should fail
      @thing.should have(4).sub_things
    end
    
    def test_should_have_3_subthings #should pass
      @thing.should have(3).sub_things
    end
    end
    
    class Thing
    def sub_things
      [1,2,3]
    end
    end
    </code>





Assuming that you have rspec-0.8.0 or better, this should produce the following output:





    
    $ ruby thing_test.rb
    Loaded suite thing_test
    Started
    .E
    Finished in 0.000642 seconds.
    
    1) Error:
    test_should_have_4_subthings(ThingTest):
    Spec::Expectations::ExpectationNotMetError: expected 4 sub_things, got 3
      /usr/local/lib/ruby/gems/1.8/gems/rspec-0.8.1/lib/spec/expectations.rb:55:in `fail_with'
      /usr/local/lib/ruby/gems/1.8/gems/rspec-0.8.1/lib/spec/expectations/handler.rb:17:in `handle_matcher'
      /usr/local/lib/ruby/gems/1.8/gems/rspec-0.8.1/lib/spec/expectations/extensions/object.rb:28:in `should'
      thing_test.rb:15:in `test_should_have_4_subthings'
    
    2 tests, 0 assertions, 0 failures, 1 errors
    





So now, although we'd like to see people who want to use RSpec using RSpec, this should lower the barrier to those who wish to migrate existing systems gradually.
