---
author: David
comments: false
date: 2007-02-26 00:31:13+00:00
layout: post
slug: matchers-doing-double-duty
title: matchers doing double duty
wordpress_id: 18
---

When we added [generated spec descriptions](http://blog.davidchelimsky.net/articles/2007/02/21/generated-spec-names-keep-specs-dryer) to RSpec, we got a surprise second use for Matchers nearly for FREE!






With only a slight modification to [Spec::Mocks](http://rspec.rubyforge.org/rdoc/classes/Spec/Mocks.html), we are able to use the Matchers as Mock Argument Constraints as well. For example, #equal(obj) can now be used as an Expectation Matcher:





    
    <code>x = 5
    x.should equal(3)
    
    => expected 3, got 5 (using .equal?)</code>





or a Mock Argument Constraint Matcher





    
    <code>thing = mock("thing")
    thing.should_receive(:msg).with(equal(3))
    thing.msg(5)
    
    => Mock 'thing' expected :msg with (equal 3) but received it with (5)
    </code>





Thanks to Dan North for pointing me to [Hamcrest](http://code.google.com/p/hamcrest/) when we were first discussing the new expectation mechanism. It turns out that [Hamcrest](http://code.google.com/p/hamcrest/) and [jMock](http://www.jmock.org/) already employ a similar idea in Java, in which a common set of Matchers is utilized by both projects.






This is a brand new addition, and is not yet fully baked. As of now (rev 1533), there are no special methods added for better mock syntax, but we'll probably add things like #greater_than(n) so you can say #with(greater_than(n)) instead of #with(be > n), although that WILL work, however strange the syntax.






Trunksters: this is available as of rev 1533.






Everyone else: this will be released with rspec-0.8.0
