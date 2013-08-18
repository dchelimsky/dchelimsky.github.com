---
author: David
comments: false
date: 2007-03-11 05:07:25+00:00
layout: post
slug: describe-it-with-rspec
title: Describe it with RSpec
wordpress_id: 22
---

<code>module BddTools
    describe RSpec do
      it "should help you get the words right" do
        Kernel.should respond_to(:describe)
        Behaviour.should respond_to(:it)
      end
    end
    end</code>





That code produces this output:





    
    <code>BddTools::RSpec
    - should help you get the words right
    </code>





Behaviour Driven Development is all about [getting the words right](http://behaviour-driven.org/GettingTheWordsRight).






[Dan North](http://dannorth.net) has just registered [rbehave](http://rbehave.rubyforge.org) at [rubyforge](http://rubyforge.org) and is using [rspec](http://rspec.rubyforge.org) to drive ITS behaviour. Getting started, he felt that "context" and "specify" weren't speaking to him, so he wrapped them in "describe" and "it" to create the syntax in the example above.






These new words have been added to rspec's trunk and will be released with rspec-0.8.3. Combined with their elder siblings "context" and "specify", you'll now be able to choose from a wider set of words to get your specs to "speak".






Keep your eyes peeled for [rbehave](http://rbehave.rubyforge.org), an Acceptance Testing Framework that provides a Story Runner designed to promote communication between Customers, Developers and Testers. Combine rbehave's Story Runner with rspec describing lower level behaviours and you'll have the beginnings of the perfect toolset for a BDD project in Ruby.
