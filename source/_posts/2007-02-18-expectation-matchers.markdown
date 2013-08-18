---
author: David
comments: false
date: 2007-02-18 15:14:41+00:00
layout: post
slug: expectation-matchers
title: expectation matchers
wordpress_id: 11
categories:
- RSpec
---

### Expectation Matchers

RSpec 0.8 introduces a new approach to setting and verifying expectations called Expectation Matchers.
<!-- more -->

The idea of a Matcher is not new. It's just new to RSpec. Some other examples of matchers are argument matchers in dynamic mocking tools like [jmock](http://jmock.org). In fact, RSpec's own [stubbing/mocking framework](http://rspec.rubyforge.org/documentation/mocks/index.html) employs them as well.






Another example is [Hamcrest](http://code.google.com/p/hamcrest/), which is a java project that provides assertion matchers for use with junit. You can see a couple of examples in their [tutorial](http://code.google.com/p/hamcrest/wiki/Tutorial).




### How They Work




RSpec's Expectation Matchers are designed to work in concert with #should and #should_not on Object. These methods do get added to every object, however this is a much lower level of pollution than that which uses method_missing on every object!




### should and #should_not each accept either an Expectation Matcher or an expression using a specific subset of Ruby operators. See below for more on expressions using operators.



To be an Expectation Matcher, an object must respond_to #matches?(obj), #failure_message and #negative_failure_message.






When you pass an Expectation Matcher to #should, #should sends #matches?(self) to the Matcher. If #matches? returns true, the expectation passes. If false, #should then raises an ExpectationNotMetError with the result of #failure_message on the matcher.




### should_not works similarly, but raises the ExpectationNotMetError when #matches? returns true. It also uses the result of matcher.negative_failure_expectation.



Here's a concrete example:




    
    <code>class Equal
    def initialize(expected)
      @expected = expected
    end
    
    def matches?(actual)
      @actual = actual
      @actual.equal?(@expected)
    end
    
    def failure_message
      return "expected #{@expected.inspect}, got #{@actual.inspect} (using .equal?)", @expected, @actual
    end
    
    def negative_failure_message
      return "expected #{@actual.inspect} not to equal #{@expected.inspect} (using .equal?)", @expected, @actual
    end
    end
    
    #included in specify blocks
    module Matchers
    def equal(expected)
      Equal.new(expected)
    end
    end
    
    #in a spec
    context "Ruby" do
    specify "should support simple addition" do
      (2+2).should equal(4)
    end
    end
    </code>





As you can see, there's really not much to each Matcher, and the framework is so simple it hardly deserves to be called a framework.






Once we got the initial framework (what else can I call it?) in place, adding each new matcher was quite simple. Of course we toyed w/ hierarchies with default behaviour and message-building objects, etc. In the end, we found that we lost the benefits of keeping the messages DRY because getting them worded correctly in every situation was starting to require some really convoluted centralized code that was tightly bound (conceptually) to the clients it served.






We also wanted to make it easy for users to create custom expectation matchers. Frameworks tend to follow the 80/20 rule - the common 80% of the problem set is made easy, but you're on your own for the less common 20%. Since custom matchers will fall naturally into the less common 20%, it makes 0% sense to provide a framework for these.






### Operator expressions






Here are some examples of expressions using operators:





    
    <code>result.should == 3
    result.should be > 7
    result.should =~ /some regexp/
    </code>





My favorite of these is the "should be" collection. It turns out that Ruby converts that to this:





    
    <code>result.should be.>(7)
    </code>





So it's the result of #be that gets #> called on it. Because this is part of the language, Ruby doesn't complain about the lack of parens. Sweet!
