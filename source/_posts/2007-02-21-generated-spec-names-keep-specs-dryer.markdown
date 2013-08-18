---
author: David
comments: false
date: 2007-02-21 17:35:01+00:00
layout: post
slug: generated-spec-names-keep-specs-dryer
title: generated spec names keep specs DRYer
wordpress_id: 13
categories:
- RSpec
- Rails
---

[Updated on 2/25]

Have you seen this show up in your specs?

    specify "should be empty" do
      @group.should be_empty
    end

As of rev 1519, RSpec will now take (almost) all of the stock expectations and auto-generate spec names for you. So this:

    context "A Group" do
      ...
      specify do
        @group.should be_empty
      end
    end

A Group
- should be empty
This works for all of the standard expectations except those that take blocks, which would result in names like “should satisfy block”, which doesn’t seem that helpful.

Custom Expectation Matchers
Getting this to work w/ your custom matchers is a snap. Just implement #to_s in the matcher to return a String with everything after “should ” or “should not ”. For example, Equal#to_s in RSpec looks like this:

    def description
      "equal #{@expected.inspect}"
    end

So the following specs:

    specify do
      result.should equal(3)
    end
    
    specify do
      result.should_not equal("this string")
    end

would result in the following output:

    - should equal(3)
    - should not equal(\"this string\")

