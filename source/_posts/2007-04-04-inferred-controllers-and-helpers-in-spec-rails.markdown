---
author: David
comments: false
date: 2007-04-04 06:01:30+00:00
layout: post
slug: inferred-controllers-and-helpers-in-spec-rails
title: Inferred Controllers and Helpers in Spec::Rails
wordpress_id: 24
---

Here's a nice little enhancement in Spec::Rails-0.9.






Up until now, controller examples required that the controller be named:





    
    <code>#the old way
    context "Login Controller" do
    controller_name :login
    ...
    </code>





You'll still be able to do that, but you'll also be able to do this:





    
    <code>describe LoginController do
    ...
    </code>





... and Spec::Rails will assume that LoginController is what you want to use.






This works for your helper examples as well:





    
    <code>describe PeopleHelper do
    ...
    </code>
