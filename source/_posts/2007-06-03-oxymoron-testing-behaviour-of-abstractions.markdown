---
author: David
comments: false
date: 2007-06-03 21:59:17+00:00
layout: post
slug: oxymoron-testing-behaviour-of-abstractions
title: 'oxymoron: testing behaviour of abstractions'
wordpress_id: 34
---

The question of how test behaviour implemented in abstract classes came up on the RSpec list yesterday. This is something that comes up periodically, so I thought it worth posting about. Over the years I've seen and tried a few different approaches to dealing with this problem and I've come to an approach that feels right to me. It stems from two basic principles:








  * Abstract classes don't have any behaviour

  
  * Only remove duplication that actually exists






### Abstract classes don't have any behaviour






Abstract classes are a structural tool that we can use to share implementation between concrete classes. Sometimes they actually represent abstract types, but all too often they're misused as convenient placeholders for shared implementation. When that happens, their presence clouds meaning.






In statically typed languages like Java and C#, you can spot this misuse by looking at the types being referenced in method signatures. If no methods accept the abstract class, then it isn't really functioning as an abstract type in your system.






This is a bit more subtle in Ruby because we don't have an abstract class construct and we think in duck types instead of static or runtime types. Abstract classes are really more of a convention than a language feature.






Regardless, this rule of thumb steers me away from testing abstract classes directly.






### Only remove duplication that actually exists






This is a general rule of thumb that I like to apply whether I'm dealing with examples or subject code. Only remove **actual** duplication. If you start with something general before you have anything specific, there is a tendency to make assumptions about what the duplication will be, and those assumptions are often misguided.






In terms of abstractions, this rule of thumb guides me to extract abstraction when I see duplication rather than imposing it up front.






### Putting the two together






The question on the list was specifically about how to test methods that live in in Application in a Ruby on Rails app. For the uninitiated, Application is the base class for all controllers in an MVC framework. Ruby doesn't support abstract classes, so you **can** actually initialize Application, but AFAIK the Rails framework never does.






Based on the two principles, and given that I write executable examples first, I start by describing the behaviour of a concrete controller, developing methods directly on that controller against those examples. When a new controller comes along that should have the same behaviour, I'll often duplicate the examples and the behaviour first and then extract the duplication into shared examples and the Application controller. This way, if there are any differences at all in the expected behaviour (which there often are) it easier to figure out the exact bits that I want to extract.






Once I've got the abstraction in both the examples and code I can just plug them in to the third, fourth, etc examples.






### Other schools of thought






There is a runtime cost to pay when you're running the same examples for multiple subclasses of an abstract class. You could argue that this is wasteful because the same implementation is being tested multiple times, which flies in the face of the goal of fast running test suites. This argument might lead you to write tests directly for the abstract class.






I can't really disagree with the performance cost, yet I still prefer to approach it as I do because I find it more clear and less brittle to be describing the behaviour of concrete types rather than the behaviour of abstract types (which doesn't really exist).
