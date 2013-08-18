---
author: David
comments: true
date: 2010-10-19 04:43:44+00:00
layout: post
slug: rspec-201-is-released
title: rspec-2.0.1 is released!
wordpress_id: 2693
categories:
- BDD
- RSpec
---

This is primarily a bug-fix release for rspec-core:

### rspec-core-2.0.1

[full changelog](http://github.com/rspec/rspec-core/compare/v2.0.0...v2.0.1)

* Bug fixes
  * restore color when using spork + autotest
  * Pending examples without docstrings render the correct message (Josep M. Bach)
  * Fixed bug where a failure in a spec file ending in anything but _spec.rb would
    fail in a confusing way.
  * Support backtrace lines from erb templates in html formatter (Alex Crichton)

### rspec-expectations-2.0.1

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.0.0...v2.0.1)

* Enhancements
  * Make dependencies on other rspec gems consistent across gems

### rspec-mocks-2.0.1

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.0.0...v2.0.1)

* Enhancements
  * Make dependencies on other rspec gems consistent across gems

