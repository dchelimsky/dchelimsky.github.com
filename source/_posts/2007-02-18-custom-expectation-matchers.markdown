---
author: David
comments: false
date: 2007-02-18 16:16:42+00:00
layout: post
slug: custom-expectation-matchers
title: custom expectation matchers
wordpress_id: 12
categories:
- RSpec
---

RSpec 0.8 introduces the concept of "Expectation Matchers":/articles/2007/02/18/expectation-matchers to RSpec. Not only does this simplify RSpec's own internals, but it also makes it really simple to write your own custom expectation matchers.



Here's an example that came from a [question](http://rubyforge.org/pipermail/rspec-devel/2007-February/001982.html) on the [rspec-devel mailing list](http://rubyforge.org/pipermail/rspec-devel/).






Evgeny wanted a simple, DRY way to specify that a Rails model class should require specific fields. Here's what I came up with. I'm not convinced this is the best approach to this problem, but I'm presenting it here to demonstrate the simplicity of creating a custom matcher.





    
    <code>module ModelSpecHelper
    class Require
      def initialize(attr)
        @attr = attr
      end
    
      def matches?(model)
        @model = model
        model.send("#{@attr.to_s}=".to_sym, nil)
        return !model.valid?
      end
    
      def failure_message
        "expected #{@model.inspect} to require #{@attr.inspect}"
      end
    end
    
    def require(attr)
      Require.new(attr)
    end
    end
    
    context "User behaviour" do
    include ModelSpecHelper
    
    setup do
      @user = User.new(:email => 'a@b.com', :zip => '02134')
    end
    
    specify "should require email" do
      @user.should require(:email)
    end
    
    specify "should require zip" do
      @user.should require(:zip)
    end
    end
    </code>





The only thing I'm not comfortable with is that these specs are bound together with the setup. If you don't initialize the required attributes in setup and only one of the required attributes is actually implemented in the model, all of them will pass anyway (false positive).






I guess that could be solved by adding a parameter to #require:





    
    <code>def require(attr, valid_value)
    Require.new(attr, valid_value)
    end
    </code>





Then #matches? could assign nil to the attr and expect #valid? to return false and then assign valid_value to the attr and expect #valid? to return true. The failure message could say something like "model was not valid even when email was assigned 'a@b.com'. You must ensure that all required attributes are assigned values before calling #should require."






Making that change would be cake! Again, the point here is to show how easy custom matchers are to implement. Coming up w/ the right syntax and messaging is another problem, but RSpec does its best to stay out of your way as you explore that problem.






So I encourage you to explore custom matchers if you're using RSpec >= 0.8, and I look forward to hearing about your experiences doing so. I also encourage you to consider publishing your own libraries of custom matchers that you find generally useful.
