---
author: David
comments: true
date: 2011-05-06 11:59:52+00:00
layout: post
slug: rspec-260rc6-is-released
title: rspec-2.6.0.rc6 is released!
wordpress_id: 2778
---

We're doing one more release candidate to update rspec-rails to work with rails-3.1.0.beta1. This will hopefully be the last release candidate, with a final release coming in just a few days.

### rspec-rails-2.6.0.rc6

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.6.0.rc4...v2.6.0.rc6)

* Bug fixes
  * Fix load order issue w/ Capybara (oleg dashevskii)
  * Relax the dependencies on rails gems to >= 3.0 (Joel Moss)
  * Fix monkey patches that broke due to internal changes in rails-3.1.0.beta1

### rspec-core-2.6.0.rc6

[full changelog](http://github.com/rspec/rspec-core/compare/v2.6.0.rc4...v2.6.0.rc6)

* Enhancements
  * Restore --pattern/-P command line option from rspec-1
  * Support false as well as true in config.full_backtrace= (Andreas Tolf Tolfsen)


