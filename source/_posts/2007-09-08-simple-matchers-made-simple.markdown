---
author: David
comments: false
date: 2007-09-08 14:36:02+00:00
layout: post
slug: simple-matchers-made-simple
title: Simple Matchers made Simple
wordpress_id: 42
---

Although RSpec supports custom matchers, it has always been a bit more work than is ideal for simpler situations. This could be attributed to the desire for a system which would be flexible.






But now, with a bit of convention-over-configuration kool-aide, we offer you the SimpleMatcher.






The SimpleMatcher snuck its way into RSpec's source when we merged in the Story Runner (formerly RBehave). Dan North had wanted a simpler way to create custom matchers, and so he created one and used it throughout the specs for the Story Runner.






And now we bring it to you (today if you use trunk, otherwise next release).






Here's how you use it:





    
    <code>def beat(hand)
    return simple_matcher("hand that beats #{hand.to_s}") do |actual|
      actual.beats?(hand)
    end
    end
    
    full_house.should beat(flush)
    => nil #passes
    
    straight.should beat(flush)
    => Expected hand that beats Flush, got Straight
    </code>





Admittedly, these are only useful for very simple cases. But what's in a name?
