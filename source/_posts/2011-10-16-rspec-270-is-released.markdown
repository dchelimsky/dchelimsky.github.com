---
author: David
comments: true
date: 2011-10-16 20:28:00+00:00
layout: post
slug: rspec-270-is-released
title: rspec-2.7.0 is released!
wordpress_id: 2840
categories:
- BDD
- RSpec
- Rails
---

We're pleased to announce the release of rspec-2.7.0. Release notes for each
gem are listed below, but here are a couple of highlights:

## Just type `rspec`

With the the 2.7.0 release, if you keep all of your specs in the conventional
`spec` directory, you don't need to follow the `rspec` command with a path.
Just type `rspec`.

If you keep your specs in a different directory, just set the `--default_path`
option to that directory on the command line, or in a `.rspec` config file.

## The rake task now lets Bundler manage Bundler

The `RSpec::Core::RakeTask` invokes the `rspec` command in a subshell. In
recent releases, it assumed that you wanted it prefixed with `bundle exec` if
it saw a `Gemfile`. We then added `gemfile` and `skip_bundler` options to the
task, so you could manage this in different ways.

It turns out that Bundler manages this quite well without any help from RSpec.
If you activate Bundler in the parent shell, via the command line or
`Bundler.setup`, it sets environment variables that activate Bundler in the
subshell with the correct gemfile.

The `gemfile` and `skip_bundler` options are therefore deprecated and have no
effect.

## Release Notes

### rspec-core-2.7.0

[full changelog](http://github.com/rspec/rspec-core/compare/v2.6.4...v2.7.0)

NOTE: RSpec's release policy dictates that there should not be any backward
incompatible changes in minor releases, but we're making an exception to
release a change to how RSpec interacts with other command line tools.

As of 2.7.0, you must explicity `require "rspec/autorun"` unless you use the
`rspec` command (which already does this for you).

* Enhancements
  * Add example.exception (David Chelimsky)
  * `--default_path` command line option (Justin Ko)
  * support multiple `--line_number` options (David J. Hamilton)
      * also supports `path/to/file.rb:5:9` (runs examples on lines 5 and 9)
  * Allow classes/modules to be used as shared example group identifiers
    (Arthur Gunn)
  * Friendly error message when shared context cannot be found (Sławosz
    Sławiński)
  * Clear formatters when resetting config (John Bintz)
  * Add `xspecify` and xexample as temp-pending methods (David Chelimsky)
  * Add `--no-drb` option (Iain Hecker)
  * Provide more accurate run time by registering start time before code
    is loaded (David Chelimsky)
  * Rake task default pattern finds specs in symlinked dirs (Kelly Felkins)
  * Rake task no longer does anything to invoke bundler since Bundler already
    handles it for us. Thanks to Andre Arko for the tip.
  * Add `--failure-exit-code` option (Chris Griego)

* Bug fixes
  * Include `Rake::DSL` to remove deprecation warnings in Rake > 0.8.7 (Pivotal
    Casebook)
  * Only eval `let` block once even if it returns `nil` (Adam Meehan)
  * Fix `--pattern` option (wasn't being recognized) (David Chelimsky)
  * Only implicitly `require "rspec/autorun"` with the `rspec` command (David
    Chelimsky)
  * Ensure that rspec's `at_exit` defines the exit code (Daniel Doubrovkine)
  * Show the correct snippet in the HTML and TextMate formatters (Brian
    Faherty)

### rspec-expectations-2.7.0

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.6.0...v2.7.0)

* Enhancements
  * HaveMatcher converts argument using `to_i` (Alex Bepple & Pat Maddox)
  * Improved failure message for the `have_xxx` matcher (Myron Marston)
  * HaveMatcher supports `count` (Matthew Bellantoni)
  * Change matcher dups `Enumerable` before the action, supporting custom
    `Enumerable` types like `CollectionProxy` in Rails (David Chelimsky)

* Bug fixes
  * Fix typo in `have(n).xyz` documentation (Jean Boussier)
  * fix `safe_sort` for ruby 1.9.2 (`Kernel` now defines `<=>` for Object)
    (Peter van Hardenberg)

### rspec-mocks-2.7.0

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.6.0...v2.7.0)

* Enhancements
  * Use `__send__` rather than `send` (alextk) 
  * Add support for `any_instance.stub_chain` (Sidu Ponnappa)
  * Add support for `any_instance` argument matching based on `with` (Sidu
    Ponnappa and Andy Lindeman)

* Changes
  * Check for `failure_message_for_should` or `failure_message` instead of
    `description` to detect a matcher (Tibor Claassen)

* Bug fixes
  * pass a hash to `any_instance.stub`. (Justin Ko)
  * allow `to_ary` to be called without raising `NoMethodError` (Mikhail
    Dieterle)
  * `any_instance` properly restores private methods (Sidu Ponnappa)

### rspec-rails-2.7.0

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.6.1...v2.7.0)

* Enhancments
  * `ActiveRecord::Relation` can use the `=~` matcher (Andy Lindeman)
  * Make generated controller spec more consistent with regard to ids
    (Brent J. Nordquist)
  * Less restrictive autotest mapping between spec and implementation files
    (José Valim)
  * `require 'rspec/autorun'` from generated `spec_helper.rb` (David Chelimsky)
  * add `bypass_rescue` (Lenny Marks)
  * `route_to` accepts query string (Marc Weil)

* Internal
  * Added specs for generators using ammeter (Alex Rothenberg)

* Bug fixes
  * Fix configuration/integration bug with rails 3.0 (fixed in 3.1) in which
    `fixure_file_upload` reads from `ActiveSupport::TestCase.fixture_path` and
    misses RSpec's configuration (David Chelimsky)
  * Support nested resource in view spec generator (David Chelimsky)
  * Define `primary_key` on class generated by `mock_model("WithAString")`
    (David Chelimsky)

