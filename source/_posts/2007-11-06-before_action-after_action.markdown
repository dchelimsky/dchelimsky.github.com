---
author: David
comments: false
date: 2007-11-06 16:55:46+00:00
layout: post
slug: before_action-after_action
title: before_action/after_action
wordpress_id: 48
categories:
- RSpec
- Rails
---

A while back there was either a feature request in the [rspec tracker](http://rubyforge.org/tracker/?group_id=797), or a suggestion on one of the [rspec](http://rubyforge.org/pipermail/rspec-users/) [mailing](http://rubyforge.org/pipermail/rspec-devel/) lists, for a feature to DRY up controller specs.



The idea was that this pattern feels a bit clunky:





    
    <code>describe PersonController, "handling failed POST to create" do
    def do_post
      post :create, invalid_arguments
    end
    
    it "should redisplay the create form" do
      do_post
      response.should render_template("people/new")
    end
    
    it "should try to create a Person" do
      Person.should_receive(:create).with(invalid_arguments).and_return(false)
      do_post
    end
    end
    </code>





And it would be nice to have something that was more expressive using tags like this:





    
    <code>describe PersonController, "handling failed POST to create" do
    def do_post
      post :create, invalid_arguments
    end
    
    it "should redisplay the create form", :after => :do_post do
      response.should render_template("people/new")
    end
    
    it "should try to create a Person", :before => :do_post do
      Person.should_receive(:create).with(invalid_arguments).and_return(false)
    end
    end
    </code>





I didn't add this to rspec_on_rails because I personally find it harder to read. It also doesn't support situations where you want to stub something before the action and then set a state-based expecation after the action.






But the problem is still present, and it would be nice to have something a bit less clunky.






Well - here's what I've been experimenting with. This is NOT part of RSpec, and I may not want to include it in RSpec because I think it's somewhat particular to my personal style (as opposed to a style that I think is "right" for BDD), but it's easy enough to add to your own projects.






Here's what the specs look like:





    
    <code>describe PersonController, "handling failed POST to create" do
    def do_post
      post :create, invalid_arguments
    end
    
    it "should redisplay the create form" do
      after_post do
        response.should render_template("people/new")
      end
    end
    
    it "should try to create a Person" do
      during_post do
        Person.should_receive(:create).with(invalid_arguments).and_return(false)
      end
    end
    end
    </code>





I really like this even though it actually turns out to be a bit more verbose. I think it speaks very clearly about what is going on - especially "during_post", which describes very well when the Person.should_receive the :create message.






Here's the code in spec_helper.rb that supports this pattern:





    
    <code>[:get, :post, :put, :delete, :render].each do |action|
    eval %Q{
      def before_#{action}
        yield
        do_#{action}
      end
      alias during_#{action} before_#{action}
      def after_#{action}
        do_#{action}
        yield
      end
    }
    end
    </code>





This supports controller and view specs (hence including :render).






Please try it out and let me know what you think.
