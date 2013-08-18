---
author: David
comments: false
date: 2007-06-23 18:03:34+00:00
layout: post
slug: pending-insert-reason-here
title: pending("insert reason here")
wordpress_id: 38
---

In RSpec-1.0, we introduced a Not Yet Implemented feature. When you say …





    
    <code>it "should do something"</code>





... with no block, the summary report lists that example as not implemented.





    
    <code>37 examples, 0 failures, 1 not implemented</code>





As I started to use this I found myself doing stuff like this:





    
    <code>it "should do something"
    # do
    #   here.is(the).actual(implementation).but(commented).out
    # end
    </code>





This made me sad. I hate having things that are commented out like that, even if the summary report draws my attention to it.






Then came a conversation with [Dan](http://dannorth.net) about [rbehave](http://rbehave.rubyforge.org). In his article [introducing rbehave](http://dannorth.net/2007/06/introducing-rbehave), Dan talks about identifying pending scenarios so instead of getting failures while he's working on the objects that must implement the behaviour, he gets a nice list of scenarios that should pass pending the completion of those objects. We discussed the similarities and differences between the Not Yet Implemented feature in RSpec and the Pending feature in rbehave and agreed that RSpec should have the pending method.






And so it has come to pass.






RSpec (trunk, as of rev 2118 - will be included in 1.0.6) still supports calling #it with no block, but now also supports the #pending method, allowing you to say:





    
    <code>describe "pending example (using pending method)" do
    it %Q|should be reported as "PENDING: for some reason"| do
      pending("for some reason")
    end
    end
    
    describe "pending example (with no block)" do
    it %Q|should be reported as "PENDING: Not Yet Implemented"|
    end
    </code>





And hear:





    
    <code>$ ruby bin/spec examples/pending_example.rb -fs
    
    pending example (using pending method)
    - should be reported as "PENDING: for some reason" (PENDING: for some reason)
    
    pending example (with no block)
    - should be reported as "PENDING: Not Yet Implemented" (PENDING: Not Yet Implemented)
    
    Finished in 0.006639 seconds
    
    2 examples, 0 failures, 2 pending
    </code>





The #pending method raises a Spec::DSL::ExamplePendingError, which gets reported, in this case, as "PENDING: for some reason". If you leave off the block the example will be reported as "PENDING: Not Yet Implemented". Either way, the summary will combine these two types of pending examples as just "pending".
