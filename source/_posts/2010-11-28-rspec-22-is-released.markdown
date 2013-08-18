---
author: David
comments: true
date: 2010-11-28 22:34:37+00:00
layout: post
slug: rspec-22-is-released
title: rspec-2.2 is released!
wordpress_id: 2712
categories:
- BDD
- RSpec
- Rails
---

### rspec-core-2.2.0

[full changelog](http://github.com/rspec/rspec-core/compare/v2.1.0...master)

* Deprecations/changes
  * --debug/-d on command line is deprecated and now has no effect
  * win32console is now ignored; Windows users must use ANSICON for color support
    (Bosko Ivanisevic)

* Enhancements
  * Raise exception with helpful message when rspec-1 is loaded alongside
    rspec-2 (Justin Ko)
  * debugger statements _just work_ as long as ruby-debug is installed
    * otherwise you get warned, but not fired
  * Expose example.metadata in around hooks
  * Performance improvments (see [Upgrade.markdown](https://github.com/rspec/rspec-core/blob/master/Upgrade.markdown))

* Bug fixes
  * Make sure --fail-fast makes it across drb
  * Pass -Ilib:spec to rcov

### rspec-mocks-2.2.0

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.1.0...v2.2.0)

* Enhancements
  * Added "rspec/mocks/standalone" for exploring the rspec-mocks in irb.

* Bug fix
  * Eliminate warning on splat args without parens (Gioele Barabucci)
  * Fix bug where obj.should_receive(:foo).with(stub.as_null_object) would                                                                                                      
    pass with a false positive.

### rspec-rails-2.2.0

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.1.0...master)

* Enhancements
  * Added stub_template in view specs

* Bug fixes
  * Properly include helpers in views (Jonathan del Strother)
  * Fix bug in which method missing led to a stack overflow
  * Fix stack overflow in request specs with open_session
  * Fix stack overflow in any spec when method_missing was invoked
  * Add gem dependency on rails ~> 3.0.0 (ensures bundler won't install
    rspec-rails-2 with rails-2 apps).

