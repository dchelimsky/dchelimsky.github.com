---
author: David
comments: true
date: 2012-11-13 04:37:04+00:00
layout: post
slug: rspec-212-is-released
title: rspec-2.12 is released
wordpress_id: 2949
categories:
- BDD
- RSpec
---

rspec-2.12 is a minor release (per [SemVer](http://semver.org/)), which
includes numerous enhancements and bug fixes. It is fully backward compatible
with previous rspec-2 releases and is a recommended upgrade for all users.

Thanks to all who contributed. Special thanks to Myron Marston and Andy
Lindeman for their personal contributions to the code as well as a great job
shepherding pull requests from several new contributors.

UPDATE: If you're an rspec/rails/capybara user, be sure to read [Andy Lindeman's blog post on Capybara-2.0 and rspec-rails](http://alindeman.github.com/2012/11/11/rspec-rails-and-capybara-2.0-what-you-need-to-know.html).

## Docs

### RDoc

* [http://rubydoc.info/gems/rspec-core](http://rubydoc.info/gems/rspec-core)
* [http://rubydoc.info/gems/rspec-expectations](http://rubydoc.info/gems/rspec-expectations)
* [http://rubydoc.info/gems/rspec-mocks](http://rubydoc.info/gems/rspec-mocks)
* [http://rubydoc.info/gems/rspec-rails](http://rubydoc.info/gems/rspec-rails)

### Cucumber features

* [http://relishapp.com/rspec/rspec-core](http://relishapp.com/rspec/rspec-core)
* [http://relishapp.com/rspec/rspec-expectations](http://relishapp.com/rspec/rspec-expectations)
* [http://relishapp.com/rspec/rspec-mocks](http://relishapp.com/rspec/rspec-mocks)
* [http://relishapp.com/rspec/rspec-rails](http://relishapp.com/rspec/rspec-rails)

## Release notes

### rspec-core-2.12.0
[full changelog](http://github.com/rspec/rspec-core/compare/v2.11.1...v2.12.0)

Enhancements

* Add support for custom ordering strategies for groups and examples.
  (Myron Marston)
* JSON Formatter (Alex Chaffee)
* Refactor rake task internals (Sam Phippen)
* Refactor HtmlFormatter (Pete Hodgson)
* Autotest supports a path to Ruby that contains spaces (dsisnero)
* Provide a helpful warning when a shared example group is redefined.
  (Mark Burns).
* `--default_path` can be specified as `--default-path`. `--line_number` can be
  specified as `--line-number`. Hyphens are more idiomatic command line argument
  separators (Sam Phippen).
* A more useful error message is shown when an invalid command line option is
  used (Jordi Polo).
* Add `format_docstrings { |str| }` config option. It can be used to
  apply formatting rules to example group and example docstrings.
  (Alex Tan)
* Add support for an `.rspec-local` options file. This is intended to
  allow individual developers to set options in a git-ignored file that
  override the common project options in `.rspec`. (Sam Phippen)
* Support for mocha 0.13.0. (Andy Lindeman)

Bug fixes

* Remove override of `ExampleGroup#ancestors`. This is a core ruby method that
  RSpec shouldn't override. Instead, define `ExampleGroup#parent_groups`. (Myron
  Marston)
* Limit monkey patching of shared example/context declaration methods
  (`shared_examples_for`, etc.) to just the objects that need it rather than
  every object in the system (Myron Marston).
* Fix Metadata#fetch to support computed values (Sam Goldman).
* Named subject can now be referred to from within subject block in a nested
  group (tomykaira).
* Fix `fail_fast` so that it properly exits when an error occurs in a
  `before(:all) hook` (Bradley Schaefer).
* Make the order spec files are loaded consistent, regardless of the
  order of the files returned by the OS or the order passed at
  the command line (Jo Liss and Sam Phippen).
* Ensure instance variables from `before(:all)` are always exposed
  from `after(:all)`, even if an error occurs in `before(:all)`
  (Sam Phippen).
* `rspec --init` no longer generates an incorrect warning about `--configure`
  being deprecated (Sam Phippen).
* Fix pluralization of `1 seconds` (Odin Dutton)
* Fix ANSICON url (Jarmo Pertman)
* Use dup of Time so reporting isn't clobbered by examples that modify Time
  without properly restoring it. (David Chelimsky)

Deprecations

* `share_as` is no longer needed. `shared_context` and/or
  `RSpec::SharedContext` provide better mechanisms (Sam Phippen).
* Deprecate `RSpec.configuration` with a block (use `RSpec.configure`).



### rspec-expectations-2.12.0
[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.11.3...v2.12.0)

Enhancements

* Colorize diffs if the `--color` option is configured. (Alex Coplan)
* Include backtraces in unexpected errors handled by `raise_error`
  matcher (Myron Marston)
* Print a warning when users accidentally pass a non-string argument
  as an expectation message (Sam Phippen)
* `=~` and `match_array` matchers output a more useful error message when
  the actual value is not an array (or an object that responds to `#to_ary`)
  (Sam Phippen)

Bug fixes

* Fix `include` matcher so that `expect({}).to include(:a => nil)`
  fails as it should (Sam Phippen).
* Fix `be_an_instance_of` matcher so that `Class#to_s` is used in the
  description rather than `Class#inspect`, since some classes (like
  `ActiveRecord::Base`) define a long, verbose `#inspect`.
  (Tom Stuart)


### rspec-mocks-2.12.0
[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.11.3...v2.12.0)

Enhancements

* `and_raise` can accept an exception class and message, more closely
  matching `Kernel#raise` (e.g., `foo.stub(:bar).and_raise(RuntimeError, "message")`)
  (Bas Vodde)
* Add `and_call_original`, which will delegate the message to the
  original method (Myron Marston).

Deprecations:

* Add deprecation warning when using `and_return` with `should_not_receive`
  (Neha Kumari)


### rspec-rails-2.12.0
[full changelog](http://github.com/rspec/rspec-rails/compare/v2.11.4...v2.12.0)

Enhancements

* Support validation contexts when using `#errors_on` (Woody Peterson)
* Include RequestExampleGroup in groups in spec/api

Bug fixes

* Add `should` and `should_not` to `CollectionProxy` (Rails 3.1+) and
  `AssociationProxy` (Rails 3.0).  (Myron Marston)
* `controller.controller_path` is set correctly for view specs in Rails 3.1+.
  (Andy Lindeman)
* Generated specs support module namespacing (e.g., in a Rails engine).
  (Andy Lindeman)
* `render` properly infers the view to be rendered in Rails 3.0 and 3.1
  (John Firebaugh)
* AutoTest mappings involving config/ work correctly (Brent J. Nordquist)
* Failures message for `be_new_record` are more useful (Andy Lindeman)

