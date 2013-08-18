---
author: David
comments: true
date: 2010-10-05 04:46:46+00:00
layout: post
slug: rspec-200rc-is-released
title: RSpec-2.0.0.rc is released!
wordpress_id: 2679
categories:
- BDD
- RSpec
---

See [http://blog.davidchelimsky.net/2010/07/01/rspec-2-documentation](http://blog.davidchelimsky.net/2010/07/01/rspec-2-documentation) for links to all sorts of documentation on rspec-2.

Plan is to release rspec-2.0.0 (final) within the next week, so please install, upgrade, etc, and report issues to:

[http://github.com/rspec/rspec-core/issues](http://github.com/rspec/rspec-core/issues)  

[http://github.com/rspec/rspec-expectations/issues](http://github.com/rspec/rspec-expectations/issues)  

[http://github.com/rspec/rspec-mocks/issues](http://github.com/rspec/rspec-mocks/issues)  

[http://github.com/rspec/rspec-rails/issues](http://github.com/rspec/rspec-rails/issues)

Many thinks to all of the contributors who got us here!

## rspec-core-2.0.0.rc / 2010-10-05

[full changelog](http://github.com/rspec/rspec-core/compare/v2.0.0.beta.22...v2.0.0.rc)

* Enhancements
  * implicitly require unknown formatters so you don't have to require the file explicitly on the commmand line (Michael Grosser) 
  * add --out/-o option to assign output target
  * added fail_fast configuration option to abort on first failure
  * support a Hash subject (its([:key]) { should == value }) (Josep M. Bach)

* Bug fixes
  * Explicitly require rspec version to fix broken rdoc task (Hans de Graaff)
  * Ignore backtrace lines that come from other languages, like Java or Javascript (Charles Lowell)
  * Rake task now does what is expected when setting (or not setting) fail_on_error and verbose
  * Fix bug in which before/after(:all) hooks were running on excluded nested groups (Myron Marston)
  * Fix before(:all) error handling so that it fails examples in nested groups, too (Myron Marston)

## rspec-expectations-2.0.0.rc / 2010-10-05

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.0.0.beta.22...v2.0.0.rc)

* Enhancements
  * require 'rspec/expectations' in a T::U or MiniUnit suite (Josep M. Bach)

* Bug fixes
  * change by 0 passes/fails correctly (Len Smith)
  * Add description to satisfy matcher

## rspec-mocks-2.0.0.rc / 2010-10-05

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.0.0.beta.22...v2.0.0.rc)

* Enhancements
  * support passing a block to an expecttation block (Nicolas Braem)
    * obj.should_receive(:msg) {|&block;| ... }

* Bug fixes
  * Fix YAML serialization of stub (Myron Marston)
  * Fix rdoc rake task (Hans de Graaff)

## rspec-rails-2.0.0.rc / 2010-10-05

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.0.0.beta.22...v2.0.0.rc)

* Enhancements
  * add --webrat-matchers flag to scaffold generator (for view specs)
  * separate ActiveModel and ActiveRecord APIs in mock_model and stub_model
  * ControllerExampleGroup uses controller as the implicit subject by default (Paul Rosania)

