---
author: David
comments: false
date: 2008-06-07 20:43:28+00:00
layout: post
slug: thoughts-on-the-dance-off
title: Thoughts on the Dance-Off
wordpress_id: 66
categories:
- RSpec
---

In his [Great Test Framework Dance-Off](http://en.oreilly.com/rails2008/public/schedule/detail/1833) at [RailsConf 2008](http://en.oreilly.com/rails2008/public/content/home), [Josh Susser](http://blog.hasmanythrough.com/) compared [rspec](http://rspec.info) with [test/spec](http://rubyforge.org/projects/test-spec/) and [shoulda](http://www.thoughtbot.com/projects/shoulda). All in all I'd say he was very fair in his comparisons and I'd recommend checking out his [slides](http://hasmanythrough.com/gtfdo/gtfdo.pdf).

There were a couple of dings Josh handed rspec and I'd like to respond to them. This is not intended to sell you on using rspec if you're not already using it. In fact, you'll see that I agree with a some of Josh's criticisms.

I'd much rather see developers using frameworks like test/spec and shoulda than not using anything more expressive than test/unit out of the box, but I also cringe when I hear that someone chose a different framework for reasons that are based on inaccurate or incomplete information. I take full responsibility for that. If you're basing decisions on inaccurate or incomplete information it's because I haven't made the accurate and complete information available to you. This post is one step towards addressing that problem.

<!-- more -->

### Performance






rspec currently runs slower than test/unit and the lightweight frameworks that sit on top of test/unit like test/spec and shoulda. Fortunately, this is something that can be addressed and will become a priority for us in the coming months.






### Underlying Complexity






rspec is admittedly a complex and weighty beast. I think this is the result of several problems for which we are starting to look at solutions. We've already started to take some steps towards reducing the amount of code that gets loaded (formatters are lazy loaded - only the ones you use get loaded) and we have more work to do on that front.






There are also some efficiencies we can gain by merging the example group and story runners. Right now they both have some good things and some bad, and merging them should give us an opporunity to reduce the bad and take advantage of the good.






For me, the biggest issue is the lack of a rich, formalized extension API. There are some extension points we've exposed and documented, but this can definitely be improved.






This is going to be a priority for me in the coming months. I think that once we have that in place, we can start to pull out some of the weight in rspec into plugins that get published separately in much the same vain as Rails and Merb are doing now.






### Custom Matchers






In Josh's talk he pointed out that you can create custom assertions in 4 lines in test/unit frameworks while in rspec it took 30 or so lines. He did point out that the 30 line approach gives you far more control over error messages and that it covers the positive and negative matchers in one shot, but also commented that this extra power comes at a cost.






What Josh didn't know at the time, and this is definitely worthy of a ding for us not documenting things well enough, is rspec's `simple_matcher` method that let's you create simple matchers in just a few lines. Here's the example in test/unit from Josh's talk:





    
    
    def assert_sorted(actual, message=nil, &block)
    expected = actual.sort(&block)
    assert_equal expected, actual, "Order is wrong:"
    end
    assert_sorted(tags) { |a,b| a.name <=> b.name }
    





And here's the same thing with `simple_matcher`:





    
    
    def be_sorted
    simple_matcher("a sorted list") {|actual| actual.sort == actual}
    end
    [1,2,3].should be_sorted
    





The block is handed the actual value. If the block returns true, the expectation passes. If it returns false, it fails with the following message:





    
    
    expected "a sorted list" but got [1, 3, 2]
    





If you say `[1,2,3].should_not be_sorted` you'd get this message instead=:





    
    
    expected not to get "a sorted list", but got [1, 2, 3]
    





As of now, you don't get any control over the failure message other than the string you pass to the `simple_matcher` method, but I plan to add an optional hash that, if present, will give you more granular control over that message.






FYI - Josh was kind enough to [post this on his blog](http://blog.hasmanythrough.com/2008/6/1/the-great-test-framework-dance-off) when I sent it to him. Thanks for that Josh.






### Macros






Josh really likes the fact that shoulda ships with a bunch of macros like `should_only_allow_numeric_values_for` and `should_render_template`. This allows you to structure contexts like this (from the shoulda website):





    
    
    context "on GET to :show for first record" do
    setup do
      get :show, :id => 1
    end
    
    should_assign_to :user
    should_respond_with :success
    should_render_template :show
    should_not_set_the_flash
    
    should "do something else really cool" do
      assert_equal 1, assigns(:user).id
    end
    end
    





This is awesome stuff, and rspec-rails definitely lacks a built in set of macros like this. You can use technoweenie's [rspec_on_rails_on_crack](http://github.com/technoweenie/rspec_on_rails_on_crack) plugin, does, however, to create rspec example groups like this:





    
    
    describe ThingsController, "GET #index" do
    fixtures :things
    
    act! { get :index }
    
    before do
      @things = []
      Thing.stub!(:find).with(:all).and_return(@things)
    end
    
    it_assigns :things
    it_renders :template, :index
    end
    





You can also create your own custom macro-level matchers quite simply. Take shoulda's `should_respond_with :success` from the example above. Here's how you'd define that in rspec:





    
    
    module ControllerExampleGroupHelper
    module ClassMethods
      def should_respond_with(expected_response)
        it "should respond with #{expected_response}" do
          response.should be(expected_response)
        end
      end
    end
    
    class << self
      def included(mod)
        mod.extend ClassMethods
      end
    end
    end
    
    Spec::Runner.configure do |config|
    config.include(ControllerExampleGroupHelper, :type => :controller)
    end
    





This adds the `should_respond_with` method to all of your controller example groups. Obviously, you can just add methods to the `ControllerExampleGroupHelper::ClassMethods` module and make them available as well.






Here's how you might use this one:





    
    
    describe ThingsController do
    context "handling GET /things/1" do
      before(:each) { get :show, :id => "1" }
      should_respond_with :success
    end
    end
    





This outputs the following:





    
    
    ThingsController handling GET /things/1
    - should respond with success
    





Of course, what we really need is an rspec-shoulda plugin that ships all of these for you. Ideally this could be done by simply making the shoulda macros available in rspec example groups, but my first impression is that shoulda is too tightly tied to test/unit to do that. I'm looking into that possibility though.






### In Summary






I'm excited to see that rspec is inspiring other frameworks and that they are challenging rspec to improve on itself. Look for such improvements over the coming months.






I think that whether you choose to use rspec, shoulda, rspec's mocks or mocha or flexmock, etc, etc, this is a great time for testing frameworks in Ruby and I'm excited to be part of this r-evolution.
