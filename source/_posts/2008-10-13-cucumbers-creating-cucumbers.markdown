---
author: David
comments: false
date: 2008-10-13 09:30:00+00:00
layout: post
slug: cucumbers-creating-cucumbers
title: cucumbers creating cucumbers
wordpress_id: 1437
---

I'm preparing to present a practical demonstration of rspec, cucumber and friends at [Rails Summit Latin America](http://www.locaweb.com.br/railssummit/default.asp?prog=dia16&language=6) this Thursday.






I was playing with the idea of using cucumber/rspec to drive the development of a cucumber browser/editor, but I've decided that it ends up being a bit too meta for a conference presentation.






Of course, nothing is too meta for a blog post, and clearly I've already procrastinated a great deal if it's just a few days before and I'm still prototyping the app, so why not take some more time away from what I should be doing and post this sillyness?






And with **that** ... enjoy!





    
    
    Feature: create feature
    
    So that I can easily create new feature
    As a stakeholder
    I want to create a feature in a browser
    
    Scenario: create feature
      When I create a new feature named "Eat Cheese"
      And I give "Eat Cheese" the narrative:
        So that I can be happy
        As a cheese-loving person
        I want to eat cheese
      And I add a scenario to "Eat Cheese" named "roquefort"
      And I add a step to "roquefort" with "Given I am holding my nose"
      And I add a step to "roquefort" with "When I eat a hunk o' roquefort"
      And I add a step to "roquefort" with "Then I should smile at its deliciousness"
    
      And I save and run the "roquefort" scenario
    
      Then I should see "3 steps pending"
      And I should see:
        You can use these snippets to implement pending steps:
    
        Given /^I am holding my nose$/ do
        end
    
        When /^I eat a hunk o' roquefort$/ do
        end
    
        Then /^I should smile at its deliciousness$/ do
        end
    





DISCLAIMER: This also assumes some support for multi-line steps that has not yet been implemented and may not be supported as depicted here. So please don't try this at home.
