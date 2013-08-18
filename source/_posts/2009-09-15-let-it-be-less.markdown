---
author: David
comments: true
date: 2009-09-15 01:57:08+00:00
layout: post
slug: let-it-be-less
title: let it be @-less
wordpress_id: 2588
categories:
- RSpec
---

If you use RSpec and you're disciplined about the red/green/refactor of Test Driven Development, you probably find yourself doing this from time to time. We start off with a single example:


    
    
    describe BowlingGame do
    it "scores all gutters with 0" do
      game = BowlingGame.new
      20.times { game.roll(0) }
      game.score.should == 0
    end
    end
    



Then add second example:


    
    
    describe BowlingGame do
    it "scores all gutters with 0" do
      game = BowlingGame.new
      20.times { game.roll(0) }
      game.score.should == 0
    end
    
    it "scores all 1's with 20" do
      game = BowlingGame.new
      20.times { game.roll(1) }
      game.score.should == 20
    end
    end
    



Once we get the second example passing, we remove duplication in the examples, typically like this:


    
    
    describe BowlingGame do
    before(:each) do
      @game = BowlingGame.new
    end
    
    it "scores all gutters with 0" do
      20.times { @game.roll(0) }
      @game.score.should == 0
    end
    
    it "scores all 1's with 20" do
      20.times { @game.roll(1) }
      @game.score.should == 20
    end
    end
    



This last step involves copying the first line of each example to a `before(:each)` block, and then converting the references to `game` to an instance variable using an `@` symbol. This is tedious and error prone, but we accept that in the interest of keeping things clean.

<!-- more -->
### a convention emerges

One convention that has emerged over time is to introduce a helper method, like so:


    
    
    describe BowlingGame do
    def game
      @game ||= BowlingGame.new
    end
    
    it "scores all gutters with 0" do
      20.times { game.roll(0) }
      game.score.should == 0
    end
    
    it "scores all 1's with 20" do
      20.times { game.roll(1) }
      game.score.should == 20
    end
    end
    



With the first call to the `game` method in each example, ruby invokes the right side of the expression and stores it in the `@game` variable on the left, which is returned to the current and each subsquent caller. This approach takes up the same number of lines as the `before(:each)` block, but note the lack of `@` symbols in the examples themselves. 

Consider that there will likely be several more examples that have a similar structure, and you can see that the removal of `@` symbols reduces a fair amount of noise. Not that there's anything inherently wrong or noisy about instance variables, but for many this may just feel cleaner.

### from convention emerges solution

Thanks to a suggestion from Stuart Halloway, rspec-1.2.9 introduces a new `let()` method that lets examples move towards @-less-ness by encapsulating the process of caching the instance variable. Here's the previous example using `let()`:


    
    
    describe BowlingGame do
    let(:game) { BowlingGame.new }
    
    it "scores all gutters with 0" do
      20.times { game.roll(0) }
      game.score.should == 0
    end
    
    it "scores all 1's with 20" do
      20.times { game.roll(1) }
      game.score.should == 20
    end
    end
    



The call to `let()` in this example defines a `game` method. The first time `game` is called in each example, it invokes the block, caches the result (an instance of `BowlingGame`), and returns it. Each subsequent call to `game` returns the same object, just like the `game` method in the previous example.

This will, admittedly, not change your life. Nor will it appeal to all of you, though I expect it to appeal to the lispier among you. The thing that I've noticed is that as more of these appear in a codebase, the more meaning they begin to establish, and it actually helps to compartmentalize this pattern and separate it from other helper methods that might be floating around.

So experiment away and please feel free to provide feedback here or on the [rspec-users](http://rubyforge.org/mailman/listinfo/rspec-users) mailing list.
