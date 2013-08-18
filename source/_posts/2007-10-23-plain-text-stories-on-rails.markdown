---
author: David
comments: false
date: 2007-10-23 04:43:24+00:00
layout: post
slug: plain-text-stories-on-rails
title: Plain Text Stories on Rails
wordpress_id: 44
---

Since my last post on [plain text stories](http://blog.davidchelimsky.net/articles/2007/10/21/story-runner-in-plain-english), there have already been a few improvements, not the least of which is that it will now work with Rails. Again, this is trunk (rev 2769+) only and experimental.






Here's a working example from an app that I'm working on:




stories/login

    
    Story: registered user logs in
    As a registered user
    I want to have to log in
    So that only other registered users can see my data
    
    Scenario: user logs in and sees welcome page
      Given a user registered with login: foo and password: test
      When user logs in with login: foo and password: test
      Then user should see the welcome page
    
    Scenario: user logs in with wrong password
      Given a user registered with login: foo and password: test
      When user logs in with login: foo and password: wrong
      Then user should see the login form
      And page should include text: There was an error logging in.
    
    Scenario: user logs in with wrong login name
      Given a user registered with login: foo and password: test
      When user logs in with login: wrong and password: test
      Then user should see the login form
      And page should include text: There was an error logging in.
    





[Update: modified to use runner.steps instead of runner.step_matchers]




stories/login.rb

    
    <code>require File.join(File.dirname(__FILE__), *%w[helper])
    
    run_story :type => RailsStory do |runner|
    runner.steps << LoginSteps.new
    runner.steps << NavigationSteps.new
    runner.load File.expand_path(__FILE__).gsub(".rb","")
    end
    </code>





Here's what's new in this example:








  * run_story is added to the main object so you don't have to remember that silly path to the PlainTextStoryRunner which will undoutedbly change!

  
  * run_story accepts arguments, including an options hash, which it will pass to the constructor of the PlainTextStoryRunner (in this case, :type => RailsStory)

  
  * run_story yields the runner, which now supports a load method which you use to tell it where to find the plain text story file.

  
  * run_story … runs the story






Keep your eyes peeled for more updates in the coming days.
