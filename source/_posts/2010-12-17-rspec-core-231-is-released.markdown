---
author: David
comments: true
date: 2010-12-17 04:15:53+00:00
layout: post
slug: rspec-core-231-is-released
title: rspec-core-2.3.1 is released!
wordpress_id: 2724
categories:
- RSpec
---

[full changelog](http://github.com/rspec/rspec-core/compare/v2.3.0...v2.3.1)

* Bug fixes
  * send debugger warning message to $stdout if RSpec.configuration.error_stream
    has not been defined yet. 
  * HTML Formatter _finally_ properly displays nested groups (Jarmo Pertman)
  * eliminate some warnings when running RSpec's own suite (Jarmo Pertman)

