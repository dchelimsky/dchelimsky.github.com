---
author: David
comments: true
date: 2011-05-24 13:17:00+00:00
layout: post
slug: rspec-core-263-is-released
title: rspec-core-2.6.3 is released!
wordpress_id: 2791
categories:
- RSpec
---

This is a bug fix release that should install correctly regardless of which version of rubygems you are running.

### rspec-core-2.6.3 / 2011-05-24

[full changelog](http://github.com/rspec/rspec-core/compare/v2.6.2...v2.6.3)

* Bug fixes
  * Explicitly convert exit code to integer, avoiding TypeError when return
    value of run is IO object proxied by `DRb::DRbObject` (Julian Scheid)
  * Clarify behavior of `--example` command line option
  * Build using a rubygems-1.6.2 to avoid downstream yaml parsing error

