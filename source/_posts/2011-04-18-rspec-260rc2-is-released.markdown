---
author: David
comments: true
date: 2011-04-18 06:01:36+00:00
layout: post
slug: rspec-260rc2-is-released
title: rspec-2.6.0.rc2 is released!
wordpress_id: 2768
categories:
- RSpec
- Rails
---

We're releasing rspec-2.6.0.rc2 as a release candidate as there are some internal changes that we'd like to see put through their paces before doing a final release. Note that the changes I speak of are internal. There are no new deprecations in this release, nor any backward-incompatible changes.

There are, however, some new features that we're really excited about. Please do check it out and please do report any issues to the appropriate github issue tracker:

* [rspec-core](http://github.com/rspec/rspec-core/issues)
* [rspec-expectations](http://github.com/rspec/rspec-expectations/issues)
* [rspec-mocks](http://github.com/rspec/rspec-mocks/issues)
* [rspec-rails](http://github.com/rspec/rspec-rails/issues)

### rspec-core-2.6.0.rc2

[full changelog](http://github.com/rspec/rspec-core/compare/v2.5.1...v2.6.1.rc2)

* Enhancements
  * `shared_context` (Damian Nurzynski)
      * extend groups matching specific metadata with:
          * method definitions
          * subject declarations
          * let/let! declarations
          * etc (anything you can do in a group)
  * `its([:key])` works for any subject with #[]. (Peter Jaros)
  * `treat_symbols_as_metadata_keys_with_true_values` (Myron Marston)
  * Print a deprecation warning when you configure RSpec after defining
    an example.  All configuration should happen before any examples are
    defined. (Myron Marston)
  * Pass the exit status of a DRb run to the invoking process. This causes
    specs run via DRb to not just return true or false. (Ilkka Laukkanen)
  * Refactoring of ConfigurationOptions#parse_options (Rodrigo Rosenfeld Rosas)
  * Report excluded filters in runner output (tip from andyl)

* Bug fixes
  * Don't stumble over an exception without a message (Hans Hasselberg)
  * Remove non-ascii characters from comments that were choking rcov (Geoffrey
    Byers)
  * Fixed backtrace so it doesn't include lines from before the autorun at_exit
    hook (Myron Marston)
  * Include RSpec::Matchers when first example group is defined, rather
    than just before running the examples.  This works around an obscure
    bug in ruby 1.9 that can cause infinite recursion. (Myron Marston)
  * Don't send example_group_[started|finished] to formatters for empty groups.
  * Get specs passing on jruby (Sidu Ponnappa)
  * Fix bug where mixing nested groups and outer-level examples gave
    unpredictable :line_number behavior (Artur Małecki)
  * Regexp.escape the argument to --example (tip from Elliot Winkler)
  * Correctly pass/fail pending block with message expectations

### rspec-expectations-2.6.0.rc2

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.5.0...v2.6.1.rc2)

* Enhancments
  * `change` matcher accepts Regexps (Robert Davis)
  * better descriptions for have_xxx matchers (Magnus Bergmark)

* Bug fixes
  * Removed non-ascii characters that were choking rcov (Geoffrey Byers)
  * change matcher dups arrays and hashes so their before/after states can be
    compared correctly.
  * Fix the order of inclusion of RSpec::Matchers in
    Test::Unit::TestCase and MiniTest::Unit::TestCase to prevent a
    SystemStackError (Myron Marston)


### rspec-mocks-2.6.0.rc2

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.5.0...v2.6.1.rc2)

* Enhancements
  * Add support for any_instance.stub and any_instance.should_receive (Sidu
    Ponnappa and Andy Lindeman)

* Bug fixes
  * fix bug in which multiple chains with shared messages ending in hashes
    failed to return the correct value

### rspec-rails-2.6.0.rc2

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.5.0...v2.6.1.rc2)

* Enhancments
  * rails 3 shortcuts for routing specs (Joe Fiorini)
  * support nested resources in generators (Tim McEwan)
  * require 'rspec/rails/mocks' to use `mock_model` without requiring the whole
    rails framework

* Bug fixes
  * fix typo in "rake spec:statsetup" (Curtis Schofield)
  * expose named routes in anonymous controller specs (Andy Lindeman)
  * error when generating namespaced scaffold resources (Andy Lindeman)


