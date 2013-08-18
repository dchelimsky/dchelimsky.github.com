---
author: David
comments: true
date: 2012-03-17 23:10:59+00:00
layout: post
slug: rspec-290-is-released
title: rspec-2.9.0 is released!
wordpress_id: 2889
categories:
- RSpec
- Rails
- Ruby
---

rspec-2.9.0 is released wtih lots of bug fixes and a few minor feature improvements as well. Enjoy!

### rspec-core-2.9.0 / 2012-03-17
[full changelog](http://github.com/rspec/rspec-core/compare/v2.8.0...v2.9.0)

Enhancements

* Support for "X minutes X seconds" spec run duration in formatter. (uzzz)
* Strip whitespace from group and example names in doc formatter.
* Removed spork-0.9 shim. If you're using spork-0.8.x, you'll need to upgrade
  to 0.9.0.

Bug fixes

* Restore `--full_backtrace` option
* Ensure that values passed to `config.filter_run` are respected when running
  over DRb (using spork).
* Ensure shared example groups are reset after a run (as example groups are).
* Remove `rescue false` from calls to filters represented as Procs
* Ensure described_class gets the closest constant (pyromaniac)
* In "autorun", don't run the specs in the at_exit hook if there was an
  exception (most likely due to a SyntaxError). (sunaku)
* Don't extend groups with modules already used to extend ancestor groups.
* `its` correctly memoizes nil or false values (Yamada Masaki)

### rspec-expectations-2.9.0 / 2012-03-17
[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.8.0...v2.9.0)

Enhancements

* Move built-in matcher classes to RSpec::Matchers::BuiltIn to reduce pollution
  of RSpec::Matchers (which is included in every example).
* Autoload files with matcher classes to improve load time.

Bug fixes

* Align `respond_to?` and `method_missing` in DSL-defined matchers.
* Clear out user-defined instance variables between invocations of DSL-defined
  matchers.
* Dup the instance of a DSL generated matcher so its state is not changed by
  subsequent invocations.
* Treat expected args consistently across positive and negative expectations
  (thanks to Ralf Kistner for the heads up)

### rspec-mocks-2.9.0 / 2012-03-17
[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.8.0...v2.9.0)

Enhancements

* Support order constraints across objects (preethiramdev)

Bug fixes

* Allow a `as_null_object` to be passed to `with`
* Pass proc to block passed to stub (Aubrey Rhodes)
* Initialize child message expectation args to match any args (#109 -
  preethiramdev)

### rspec-rails-2.9.0 / 2012-03-17
[full changelog](http://github.com/rspec/rspec-rails/compare/v2.8.1...v2.9.0)

Enhancments

* add description method to RouteToMatcher (John Wulff)
* Run "db:test:clone_structure" instead of "db:test:prepare" if Active Record's
  schema format is ":sql". (Andrey Voronkov)

Bug fixes

* `mock_model(XXX).as_null_object.unknown_method` returns self again
* Generated view specs use different IDs for each attribute.

