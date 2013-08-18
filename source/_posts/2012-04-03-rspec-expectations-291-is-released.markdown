---
author: David
comments: true
date: 2012-04-03 19:18:10+00:00
layout: post
slug: rspec-expectations-291-is-released
title: rspec-expectations-2.9.1 is released!
wordpress_id: 2892
categories:
- BDD
- RSpec
- Ruby
---

This is a bug-fix only release, and is recommended for everybody using rspec-2.9.

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.9.0...v2.9.1)

Bug fixes

* Provide a helpful message if the diff between two objects is empty.
* Fix bug diffing single strings with multiline strings.
* Fix for error with using custom matchers inside other custom matchers
  (mirasrael)
* Fix using execution context methods in nested DSL matchers (mirasrael)

