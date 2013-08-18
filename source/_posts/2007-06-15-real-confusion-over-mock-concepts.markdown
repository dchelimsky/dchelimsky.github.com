---
author: David
comments: false
date: 2007-06-15 15:20:44+00:00
layout: post
slug: real-confusion-over-mock-concepts
title: Real Confusion over Mock Concepts
wordpress_id: 37
---

Various dictionaries define Mock (the noun) as an imitation, a counterfeit, a fake. The term "Mock Object" initially meant exactly that - an imitation object, which serves as a control (i.e. invariant) in a test, allowing you to limit the variables in your test to the object being tested.






Over time, new, more specific definitions have emerged and confusion has ensued. Now we are calling these things "Test Doubles", of which there can be several types including what we now call Mocks and Stubs. And to make matters worse, if I use what we now call Mocks, I'm a **Mockist** and if I use what we now call Stubs I'm a **Classicist**. Why can't we just use both of these tools when each is appropriate and dispense with the name calling?






But I digress.






The main problem that I see with all of this is that the thing that separates the different kinds of Test Doubles is really how they behave at the individual message/method level. We have frameworks called Mocking Frameworks that create objects you can train to supply pre-defined responses (in which case its acting like a Stub), record messages (in which case it's a Recording Stub), and even verify that specific messages are received (in which case its a Mock). The same object can have all of these behaviours, so the struggle over what to call the object seems to miss the point.






And to make matters more confusing, mocking frameworks in dynamic languages like Ruby give you the ability to treat any real object in your system in the same way as you treat a generated Mock, Fake, Test Double, Test Spy, etc, etc, etc. In RSpec, for example, you can do this:





    
    <code>real_collaborator = RealCollaborator.new
    real_collaborator.should_receive(:some_message)
    object_i_am_describing = InterestingClass.new(real_collaborator)
    object_i_am_describing.do_something_that_should_send_some_message_to_collaborator
    </code>





So what can we call this object? It's real, but it behaves like a Mock because I tell it to. This has always been considered a mocking no-no for many reasons. For example, you risk replacing methods that other methods in the same class rely on, which can lead to some unexpected test failures or, worse, passing tests that should be failing. In practice, I find that I only do this when dealing with other frameworks that rely on class methods (like Ruby on Rails' ActiveRecord).






But, again, I digress.






#### Fighting confusion with more confusion






Of late, I've gotten into the habit of talking about these things at the method level. You have an object (Test Double or Real Object) that can have Method Stubs and Message Expectations, either of which can return Stub Values. I'm hopeful that these are self-explanatory, but in the interest of minimizing confusion:






By "Test Double" I mean the [Meszaros definition](http://xunitpatterns.com/Test%20Double.html). Essentially, a test-specific substitute for a real object.






By "Method Stub" I mean a no-op implementation of a method that may or may not be called at any time during the test. A Method Stub returns a Stub Value unless it returns nil, None, void, nirvana, etc.






By "Message Expectation" I mean an expectation that a specific message will be received by the Test Double.






By "Stub Value" I mean a single, pre-defined value that will be returned by a Method Stub regardless of whether or not it is associated with a Message Expectation.






I recognize that I risk adding to the confusion instead of minimizing it, however I think this makes the whole thing easier to understand. What do you think?
