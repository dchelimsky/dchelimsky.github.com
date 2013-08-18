---
author: David
comments: false
date: 2007-10-25 09:52:20+00:00
layout: post
slug: plain-text-stories-part-iii
title: 'Plain Text Stories: Part III'
wordpress_id: 45
---

Here's the latest update to [Plain Text](http://blog.davidchelimsky.net/articles/2007/10/21/story-runner-in-plain-english) [Stories](/articles/2007/10/22/plain-text-stories-on-rails). Effective r2789 in RSpec's trunk.






Step 1: Write a Story





    
    <code>Story: simple addition
    
    As an accountant
    I want to add numbers
    So that I can count beans
    
    Scenario: add one plus one
      Given an addend of 1
      And an addend of 1
    
      When the addends are added
    
      Then the sum should be 2
      And the corks should be popped
    
    Scenario: add two plus five
      Given an addend of 2
      And an addend of 5
    
      When the addends are added
    
      Then the sum should be 7
    </code>





Step 2: Create Steps





    
    <code># This creates steps for :addition
    steps_for(:addition) do
    Given("an addend of $addend") do |addend|
      @adder ||= Adder.new
      @adder << addend.to_i
    end
    end
    
    # This appends to them
    steps_for(:addition) do
    When("the addends are added")  { @sum = @adder.sum }
    Then("the sum should be $sum") { |sum| @sum.should == sum.to_i }
    end
    </code>





Step 3: Let her open the box … no, that's not it …






Step 3: Run the Story with the steps you want (adding any that are only for this story as you go).





    
    <code>with_steps_for :addition do
    Then("the corks should be popped") {}
    run 'path/to/story/file'
    end
    </code>





Working with Rails?





    
    <code>with_steps_for :navigation do
    run 'path/to/story/file', :type => RailsStory
    end
    </code>





What about multiple groups of steps?





    
    <code>
    with_steps_for :login, :navigation, :form_submissions do
    run 'path/to/story/file'
    end
    </code>





Coming soon to a computer near you … (as soon as you can "seven up")
