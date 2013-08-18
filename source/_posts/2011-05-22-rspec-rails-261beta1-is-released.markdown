---
author: David
comments: true
date: 2011-05-22 06:08:11+00:00
layout: post
slug: rspec-rails-261beta1-is-released
title: rspec-rails-2.6.1.beta1 is released!
wordpress_id: 2787
categories:
- RSpec
- Rails
---

This is a beta release intended to provide something that works with
rails-3.1.0.rc1. It is _not_ compatible with `rails-3.1.0.beta1` or
`rake-0.9.0` (make sure you specify rake-0.8.7 in your Gemfile), but it is
compatible with every other release of `rails` from `3.0.0` through
`3.1.0.rc1`.

### rspec-rails-2.6.1.beta1 / 2011-05-22

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.6.0...v2.6.1.beta1)

This release is compatible with rails-3.1.0.rc1, but not rails-3.1.0.beta1

* Bug fixes
  * fix controller specs with anonymous controllers with around filters
  * exclude spec directory from rcov metrics
  * guard against calling prerequisites on nil default rake task (Jack Dempsey)

