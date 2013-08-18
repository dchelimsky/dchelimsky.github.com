---
author: David
comments: true
date: 2010-12-12 23:43:59+00:00
layout: post
slug: rspec-230-is-released
title: rspec-2.3.0 is released!
wordpress_id: 2720
categories:
- BDD
- RSpec
---

### rspec-core-2.3.0 / 2010-12-12

[full changelog](http://github.com/rspec/rspec-core/compare/v2.2.1...v2.3.0)

* Enhancements
    * tell autotest to use "rspec2" if it sees a .rspec file in the project's root directory
        * replaces the need for ./autotest/discover.rb, which will not work with all versions of ZenTest and/or autotest
    * config.expect_with
        * :rspec          # => rspec/expectations
        * :stdlib         # => test/unit/assertions
        * :rspec, :stdlib # => both

* Bug fixes
    * fix dev Gemfile to work on non-mac-os machines (Lake Denman)
    * ensure explicit subject is only eval'd once (Laszlo Bacsi)

### rspec-expectations-2.3.0 / 2010-12-12

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.2.1...v2.3.0)

* Enhancements
  * diff strings when include matcher fails (Mike Sassak)

### rspec-mocks-2.3.0 / 2010-12-12

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.2.1...v2.3.0)

* Bug fixes 
  * Fix our Marshal extension so that it does not interfere with objects that
    have their own @mock_proxy instance variable. (Myron Marston)

### rspec-rails-2.3.0 / 2010-12-12

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.2.1...v2.3.0)

* Changes
  * Generator no longer generates autotest/autodiscover.rb, as it is no longer
    needed (as of rspec-core-2.3.0)

