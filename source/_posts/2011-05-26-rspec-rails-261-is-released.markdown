---
author: David
comments: true
date: 2011-05-26 02:24:04+00:00
layout: post
slug: rspec-rails-261-is-released
title: rspec-rails-2.6.1 is released!
wordpress_id: 2793
categories:
- RSpec
- Rails
---

This is a bug fix release that is compatible with the rails-3.0.0 to 3.0.7, 3.0.8.rc1, and 3.1.0.rc1 (it is mostly, but not fully compatible with but not rails-3.1.0.beta1).

### rspec-rails-2.6.1 / 2011-05-25

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.6.0...v2.6.1)

* Bug fixes
  * fix controller specs with anonymous controllers with around filters
  * exclude spec directory from rcov metrics (Rodrigo Navarro)
  * guard against calling prerequisites on nil default rake task (Jack Dempsey)

