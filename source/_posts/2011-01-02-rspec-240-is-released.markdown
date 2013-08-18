---
author: David
comments: true
date: 2011-01-02 22:37:59+00:00
layout: post
slug: rspec-240-is-released
title: rspec-2.4.0 is released!
wordpress_id: 2734
categories:
- RSpec
- Rails
---

Changes in rspec-core and rspec-rails are listed below. There are no changes to
rspec-mocks and rspec-expectations for this release. 

### rspec-core-2.4.0 / 2011-01-02

[full changelog](http://github.com/rspec/rspec-core/compare/v2.3.1...v2.4.0)

* Enhancements
  * start the debugger on -d so the stack trace is visible when it stops
    (Clifford Heath)
  * apply hook filtering to examples as well as groups (Myron Marston)
  * support multiple formatters, each with their own output
  * show exception classes in failure messages unless they come from RSpec
    matchers or message expectations
  * before(:all) { pending } sets all examples to pending

* Bug fixes
  * fix bug due to change in behavior of reject in Ruby 1.9.3-dev (Shota Fukumori)
  * fix bug when running in jruby: be explicit about passing block to super
    (John Firebaugh)
  * rake task doesn't choke on paths with quotes (Janmejay Singh)
  * restore --options option from rspec-1
  * require 'ostruct' to fix bug with its([key]) (Kim Burgestrand)
  * --configure option generates .rspec file instead of autotest/discover.rb


### rspec-rails-2.4.0 / 2011-01-02

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.3.1...2.4.0)

* Enhancements
  * include ApplicationHelper in helper object in helper specs
  * include request spec extensions in files in spec/integration
  * include controller spec extensions in groups that use :type => :controller
    * same for :model, :view, :helper, :mailer, :request, :routing

* Bug fixes
  * restore global config.render_views so you only need to say it once
  * support overriding render_views in nested groups
  * matchers that delegate to Rails' assertions capture
    ActiveSupport::TestCase::Assertion (so they work properly now with
    should_not in Ruby 1.8.7 and 1.9.1)

* Deprecations
  * `include_self_when_dir_matches`

