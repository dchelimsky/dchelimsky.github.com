---
author: David
comments: false
date: 2009-02-02 19:36:00+00:00
layout: post
slug: rspec-works-with-test-unit
title: RSpec works with test/unit
wordpress_id: 1543
categories:
- RSpec
---

[Updated to Sept 5, 2009]

Did you know that [rspec](http://github.com/dchelimsky/rspec) is interoperable with test/unit?

[spec/rails](http://github.com/dchelimsky/rspec-rails) (formerly rspec\_on\_rails) has always run on test/unit and rspec (core) has had t/u interop capability for over a year now.

Take, for example, this test in addition_test.rb:


    
    
    require 'test/unit'
    
    class TestAddition < Test::Unit::TestCase
    def test_add_1_and_2
      assert_equal 3, 1 + 2
    end
    end
    




    
    
    $ ruby addition_test
    




    
    
    Loaded suite /Users/david/projects/ruby/tmp/tur/addition_test
    Started
    .
    Finished in 0.000289 seconds.
    
    1 tests, 1 assertions, 0 failures, 0 errors
    



Now, simply require 'spec/test/unit':


    
    
    require 'rubygems'
    require 'spec/test/unit'
    
    class TestAddition < Test::Unit::TestCase
    def test_add_1_and_2
      assert_equal 3, 1 + 2
    end
    end
    



Run it with the spec command that is installed when you install rspec:


    
    
    $ spec addition_test
    



And *tada*!


    
    
    .
    
    Finished in 0.001451 seconds
    
    1 example, 0 failures
    



RSpec is running your tests!


<!-- more -->So why would you do this? Well, for starters, now you can run this with any of RSpec’s command line options. This prints out the name of each test class and test method:

    
    $ spec addition_test.rb --format specdoc
    
    TestAddition
    - test_add_1_and_2
    
    1 example, 0 failures


Try it with html:

    
    $ spec addition_test_with_rspec.rb --format html:report.html


Now open up report.html and voila!

![rspec-results](http://blog.davidchelimsky.net/wp-content/uploads/2009/06/rspec-results.png)

Wanna **should** in your tests?

    
    def test_add_1_and_2
    (1 + 2).should == 3
    end


Wanna **assert** in your rspec code examples?

    
    describe "adding in Ruby" do
    it "returns 3 for 2 + 1" do
      assert_equal 3, 1 + 2
    end
    end


When you invoke rspec’s test/unit bridge, rspec and test/unit become completely interoperable. This means that most of the extensions and plugins for both libraries are available to you at the same time. I say _most_ because libs that monkey patch their way into internals of either don’t always play nice in this environment.

This also means that transitioning from an existing test/unit suite to an rspec suite is as simple as changing a single require statement and then gradually changing the tests to rspec code examples. You can run them all together during this refactoring, so you don’t have to do this all at once, and you can keep moving on your project with little to no penalty.

So if you’re choosing an alternative framework because you prefer its syntax, more power to you. If you’re choosing it because you understand its internals better, right on! Have at it. But if you’re choosing it only because it plays nice with test/unit and you didn’t know that rspec does as well, well, now you know.
