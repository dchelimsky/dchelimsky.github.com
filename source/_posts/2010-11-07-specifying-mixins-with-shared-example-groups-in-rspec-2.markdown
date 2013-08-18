---
author: David
comments: true
date: 2010-11-07 17:41:24+00:00
layout: post
slug: specifying-mixins-with-shared-example-groups-in-rspec-2
title: Specifying mixins with shared example groups in RSpec-2
wordpress_id: 2701
categories:
- BDD
- RSpec
---

One question that comes up on the [rspec-users mailing list](http://rubyforge.org/mailman/listinfo/rspec-users) / [google group](http://groups.google.com/group/rspec) is: "How do I specify modules that get mixed into other modules and classes?"

This is a great question and, naturally, leads to a wide variety of answers depending on context. I'm going to approach this generally, and explain my viewpoint about it, but keep in mind that _context is everything_, and YMMV. That said:

## In theory
With a tool like [RSpec](http://relishapp.com/rspec), the goal is to specify responsibilities of objects from the perspective of their consumers. Consider this structure:


    
    
    module M
    end
    
    class C
     include M
    end
    



If module M is included in class C, consumers of class C have no reason to know that module M is involved. They just care about the behaviour. Same is true of classes A, B, and D, if they each include module M. Keeping in mind that each host class/module/object (those that include or extend M) can override any of the behaviour of M, _**each host should be specified independently**_.

Additionally, if module M enforces some rule, like host objects (i.e. classes and modules that include or extend M) must implement method F, then that responsibility belongs to M, and should be specified in the context of M, not any of its host classes/objects. These rules can be further broken down into rules enforced at mix-in time and rules enforced at runtime.

So we're interested in specifying two fundamentally different things

* the behaviour of each class/object that mixes in M in response to events triggered by their consumers
* the behaviour of M in response to being mixed-in

## In practice

### Specifying the behaviour of a module in response to being mixed in

Imagine we are developing a module that exposes a bunch of methods related to a person's age: `can_vote?`, `can_drink?`, etc. For this to work, the host object needs to supply the birthdate of the person in question. These sorts of requirements are often documented for us by library providers, but less often required programatically. It would be nice to provide a clear message to the developer when 

For this, I'll typically mix M into anonymous classes and objects and specify what happens:


    
    
    describe AgeBasedApprovable do
      it "requires host object to provide a 'birthdate' method" do
        host = Object.new
        expect do
          host.extend(AgeBasedApprovable)
        end.to raise_error(/Objects that extend AgeBasedApprovable must provide a 'birthdate' method/)
      end
    end
    



### Specifying the behaviour of host classes/objects

For this, I've used a combination of shared example groups and custom macros in the past, but the macros are not necessary any longer. Thanks to some lively discussion [1-5], and code from [Wincent Colaiuta](https://wincent.com/), [Ashley Moran](http://twitter.com/ashleymoran) and [Myron Marston](http://twitter.com/myronmarston), shared example groups just got _awesome_ in [rspec-2.0](http://relishapp.com/rspec)! They can now be parameterized and/or customized in three different ways. The biggest change came from having `it_should_behave_like` (and its new alias, `it_behaves_like`), generate a nested example group instead of mixing a module directly into the host group. This means that this:

    
    
    shared_examples_for M do
      it "does something" do
        # ....
      end
    end
    
    describe C do
      it_behaves_like M
    end
    



... is equivalent to this:


    
    
    describe C do
      context "behaves like M" do 
        it "does something" do
          # ....
        end
      end
    end
    



In rspec-1, shared groups are modules that get mixed into the host group, which means material defined in the shared group can impact the host group in surprising ways. With this new structure in rspec-2, the nested group is a completely separate group, and the combination of sharing behaviour (through inheritance) and isolating behaviour (through encapsulation) provides power we never had before in RSpec.

## Customizing shared example groups

Here are three techniques for customizing shared groups:

### Parameterization


    
    
    describe Host do
      it_should_behave_like M, Host.new
    end
    



Here, the result of Host.new is passed to the shared group as a block parameter, making that value available at the group level (each example group is a class), and the instance level (each example runs in an _instance_ of that class). So ...


    
    
    shared_examples_for M do |host|
      it "can access #{host} in the docstring" do
        host.do_something # it can access the host _in_ the example
      end
    end
    



### Methods defined in host group


    
    
    describe Host do
      let(:foo) { Host.new }
      it_should_behave_like M
    end
    



In this case, the `foo()` method defined by `let()` is inherited by the generated nested group, and available within any of the examples defined in the shared group.


    
    
    shared_examples_for M do
      it "does something" do
        foo
      end
    end
    



NOTE that instance methods that are inherited like this are not available in the class scope of the generated example group, and are therefore not available for use in docstings:


    
    
    shared_examples_for M do
      it "does some #{foo}" do # this would raise an error
        # ...
      end
    end
    



### Methods defined in an extension block


    
    
    describe Host do
      it_should_behave_like M do
        let(:foo) { Host.new }
      end
    end
    



The block passed to `it_should_behave_like()` is eval'd after the shared group is eval'd, allowing you to define default implementations of methods in the shared group. This means we can define groups that programmatically enforce rules for the host groups. For example:


    
    
    shared_examples_for M do
      def foo
        raise "Groups that include shared examples for M must provide a foo method"
      end
    
      it "does something needing foo" do
        foo
      end
    end 
    



Now library authors can now ship shared groups that will programmatically instruct end users how to use them!

[1] [http://github.com/rspec/rspec-core/issues/issue/71](http://github.com/rspec/rspec-core/issues/issue/71)  

[2] [http://github.com/rspec/rspec-core/issues/issue/74](http://github.com/rspec/rspec-core/issues/issue/74)  

[3] [http://groups.google.com/group/rspec/browse_thread/thread/f5620df1c42874bf#](http://groups.google.com/group/rspec/browse_thread/thread/f5620df1c42874bf#)  

[4] [http://groups.google.com/group/rspec/browse_thread/thread/16d553ee2e51ccbd#](http://groups.google.com/group/rspec/browse_thread/thread/16d553ee2e51ccbd#)  

[5] [http://groups.google.com/group/rspec/browse_thread/thread/a23d5fb84a31f11e#](http://groups.google.com/group/rspec/browse_thread/thread/a23d5fb84a31f11e#)  


