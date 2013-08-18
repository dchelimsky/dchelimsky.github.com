---
author: David
comments: false
date: 2007-01-21 00:26:15+00:00
layout: post
slug: view-specs-are-about-to-get-a-whole-lot-easier
title: view specs are about to get a whole lot easier
wordpress_id: 8
---

The next release of rspec_on_rails will include a complete port of assert_select. So now you'll be able to spec your login form like this:





    
    
    <code>
    context "login/login" do
    setup do
      render 'login/login.rhtml'
    end
    
    specify "should display login form" do
      response.should have_tag("form[action=/login]") {
        with_tag("input[type=text][name=email]")
        with_tag("input[type=password][name=password]")
        with_tag("input[type=submit][value=Login]")
      }
    end
    end
    


`



How sweet is that!!!






Trunk-sters out there can do this right now. The rest can expect a release within the next couple of weeks.
