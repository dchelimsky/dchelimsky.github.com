---
author: David
comments: false
date: 2007-05-26 21:24:36+00:00
layout: post
slug: raise_controller_errors
title: raise_controller_errors
wordpress_id: 31
---

Controller examples in Spec::Rails used to implicitly raise errors by overriding rescue_action like this:





    
    <code>def rescue_action(e) do |e| raise e; end</code>





This requires that you explicitly override rescue_action in your controllers if you want to see errors being raised. To make this a bit easier, I just added a new method (trunk r2041 - will be released in 1.0.4) for controller examples that lets you do this:





    
    <code>describe SomeController do
    before(:each) do
      raise_controller_errors
    end
    ...
    end
    </code>





This causes the rescue_action above to get defined on the controller class at runtime. And to make it even easier, spec/spec_helper.rb now calls this by default:





    
    <code>Spec::Runner.configure do |config|
    ...
    config.before(:each, :behaviour_type => :controller) do
      raise_controller_errors
    end
    ...
    end
    </code>





So rescue_action will be defined by default, but you roll your own by deleting those lines in spec_helper.rb.
