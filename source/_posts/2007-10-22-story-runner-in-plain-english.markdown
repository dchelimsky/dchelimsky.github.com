---
author: David
comments: false
date: 2007-10-22 01:24:53+00:00
layout: post
slug: story-runner-in-plain-english
title: Story Runner in Plain English
wordpress_id: 43
---

#### Houston, we have Plain Text!


I just committed a first stab at a Plain Text Story Runner. It's in RSpec's trunk and will be (in some form) part of the next release.

Big thanks to [Pat Maddox](http://evang.eli.st/blog/) for the StoryPartFactory (which is now called StoryMediator) and to all on the rspec-users list who contributed their ideas and thoughts to the discussion about plain text stories.

Keep in mind that this is brand new and very experimental. I do not recommend that you start converting all your projects to using this.


That said …


#### A bit of background




[Update: modified to use And for multiple Givens, Whens or Thens]




The initial implementation of Story Runner supported syntax like this (slightly modified from Dan North's article [introducing rbehave](http://dannorth.net/2007/06/introducing-rbehave)):



    
    Story "transfer to cash account",
    %(As a savings account holder
    I want to transfer money from my savings account
    So that I can get cash easily from an ATM) do
    
    Scenario "savings account is in credit" do
      Given "my savings account balance is", 100 do |balance|
        @savings_account = Account.new(balance)
      end
      And "my cash account balance is", 10 do |balance|
        @cash_account = Account.new(balance)
      end
      When "I transfer", 20 do |amount|
        @savings_account.transfer_to(@cash_account, amount)
      end
      Then "my savings account balance should be", 80 do |expected_amount|
        @savings_account.balance.should == expected_amount
      end
      And "my cash account balance should be", 30 do |expected_amount|
        @cash_account.balance.should == expected_amount
      end
    end
    
    Scenario "savings account is overdrawn" do
      Given "my savings account balance is", -20
      And "my cash account balance is", 10
      When "I transfer", 20
      Then "my savings account balance should be", -20
      And "my cash account balance should be", 10
    end
    end
    





While this is a really cool start, there are a couple of problems. One is that we're constrained in the way we phrase things. Because the arguments become part of the phrase, we have to structure each phrase so that the argument comes at the end.






The other problem, for me, is that the differing levels of abstraction in the two scenarios make it difficult to read.






#### Enter Blockless Steps and Parameterized Steps






The first step in resolving this problem was to decouple the expression of the story from the steps, which is accomplished with the use of Parameterized Steps. Here's how the story above might look:






[Update: using StepGroup/define instead of StepMatchers/add]





    
    steps = StepGroup.new do |define|
    define.given("my savings account balance is $balance") do |balance|
      @savings_account = Account.new(balance.to_f)
    end
    
    define.given("my cash account balance is $balance" do |balance|
      @cash_account = Account.new(balance.to_f)
    end
    
    define.when("I transfer $amount") do |amount|
      @savings_account.transfer_to(@cash_account, amount.to_f)
    end
    
    define.then("my savings account balance should be $expected_amount" do |expected_amount|
      @savings_account.balance.should == expected_amount.to_f
    end
    
    define.then("my cash account balance should be $expected_amount" do |expected_amount|
      @cash_account.balance.should == expected_amount.to_f
    end
    end
    
    Story "transfer to cash account",
    %(As a savings account holder
      I want to transfer money from my savings account
      So that I can get cash easily from an ATM),
      :steps => steps do
    
    Scenario "savings account is in credit" do
      Given "my savings account balance is 100"
      And "my cash account balance is 10"
      When "I transfer 20"
      Then "my savings account balance should be 80"
      And "my cash account balance should be 30"
    end
    
    Scenario "savings account is overdrawn" do
      Given "my savings account balance is -20"
      And "my cash account balance is 10"
      When "I transfer 20"
      Then "my savings account balance should be -20"
      And "my cash account balance should be 10"
    end
    end
    





A bit nicer, yes? The steps coming first is a bit noisy, but that could be extracted to another file, or perhaps we can add a means of associating them with the Story after the Story has already been parsed so they can move below the Story.






That bit aside, look how much cleaner the Story reads now. And we can do a couple of additional things to make it even nicer. One thing you might notice is that the line about transfering (When "I transfer 20") doesn't specify which way the transfer goes. We can improve on that by enhancing that step:





    
    steps = StepGroup.new do |define|
    ...
    
    define.when("I transfer $amount from $source to $target") do |amount, source, target|
      if source == 'cash' and target == 'savings'
        @savings_account.transfer_to(@cash_account, amount.to_f)
      elsif source == 'savings' and target == 'cash'
        @cash_account.transfer_to(@savings_account, amount.to_f)
      else
        raise "I don't know how to transfer from #{source} to #{target}"
      end
    end
    
    ...
    





That lets us write the step as



  When "I transfer 20 from savings to cash"



As you can see, this is a big step towards making stories more clear and flexible.






#### More on Steps





Another thing you may have noticed is that the Steps are grouped together somewhat arbitrarily. Thanks to a couple of handy convenience methods, you can easily build up libraries of these steps and make them as broad or as granular as you like. Perhaps we want the account steps available to many stories, but the transfer step only to this one. Here's how you can handle that:




    
    class AccountSteps < Spec::Story::StepGroup
    steps do |define|
      define.given("my savings account balance is $balance") do |balance|
        @savings_account = Account.new(balance.to_f)
      end
    
      define.given("my cash account balance is $balance" do |balance|
        @cash_account = Account.new(balance.to_f)
      end
    
      define.then("my savings account balance should be $expected_amount" do |expected_amount|
        @savings_account.balance.should == expected_amount.to_f
      end
    
      define.then("my cash account balance should be $expected_amount" do |expected_amount|
        @cash_account.balance.should == expected_amount.to_f
      end
    end
    end
    
    steps = AccountSteps.new do |define|
    define.when("I transfer $amount") do |amount|
      @savings_account.transfer_to(@cash_account, amount.to_f)
    end
    end
    





Here we've created a subclass of StepGroup, instantiated one and defined an additional 'when' that will only be available to this instance.





#### Goodbye quotes!





Once we were able to get rid of the blocks, the quotes made no sense. So we've added support for true plain text stories. So now our example can read like this:





    
    Story: transfer to cash account
    As a savings account holder
    I want to transfer money from my savings account
    So that I can get cash easily from an ATM
    
    Scenario: savings account is in credit
      Given my savings account balance is 100
      And my cash account balance is 10
      When I transfer 20
      Then my savings account balance should be 80
      And my cash account balance should be 30
    
    Scenario: savings account is overdrawn
      Given my savings account balance is -20
      And my cash account balance is 10
      When I transfer 20
      Then my savings account balance should be -20
      And my cash account balance should be 10
    





That gets stored in a plain text file and you can run it by running a ruby file that looks like this:





    
    require 'spec'
    require 'path/to/your/library/files'
    require 'path/to/file/that/defines/account_steps.rb'
    
    # assumes the other story file is named the same as this file minus ".rb"
    runner = Spec::Story::Runner::PlainTextStoryRunner.new(File.expand_path(__FILE__).gsub(".rb",""))
    runner.steps << AccountSteps.new
    runner.run
    





And that's it! It's that simple. This is still in its very early phases and I'm certain there will be enhancements as people gain experience with it.






If you want to check it out yourself, grab the trunk and do the following:





    
    cd trunk/rspec
    ruby examples/stories/calculator.rb
    ruby examples/stories/addition.rb
    





The first example uses Ruby with blockless steps. The second example uses a plain text story stored in examples/stories/addition.






Also, with a couple of small tweaks we'll be able to consume plain text from any source (not just a local file) and feed it into the PlainTextStoryRunner. This means that we'll be able to do things like email scenarios to an app that consumes email and runs the scenario against the system and emails you back a report! Crazy, huh?






Lastly, just a reminder, this is only in trunk right now (as of rev 2764), so if you want to explore it you'll have to get the trunk.






Enjoy!!!!!



