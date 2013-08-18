---
author: David
comments: true
date: 2012-05-04 01:29:34+00:00
layout: post
slug: rspec-210-is-released
title: rspec-2.10 is released!
wordpress_id: 2906
---

### API Docs (RDoc)

[http://rubydoc.info/gems/rspec-core](http://rubydoc.info/gems/rspec-core)  

[http://rubydoc.info/gems/rspec-expectations](http://rubydoc.info/gems/rspec-expectations)  

[http://rubydoc.info/gems/rspec-mocks](http://rubydoc.info/gems/rspec-mocks)  

[http://rubydoc.info/gems/rspec-rails](http://rubydoc.info/gems/rspec-rails)

### Cucumber docs

[http://relishapp.com/rspec/rspec-core](http://relishapp.com/rspec/rspec-core)  

[http://relishapp.com/rspec/rspec-expectations](http://relishapp.com/rspec/rspec-expectations)  

[http://relishapp.com/rspec/rspec-mocks](http://relishapp.com/rspec/rspec-mocks)  

[http://relishapp.com/rspec/rspec-rails](http://relishapp.com/rspec/rspec-rails)

### rspec-core-2.10.0

[full changelog](http://github.com/rspec/rspec-core/compare/v2.9.0...v2.10.0)

Enhancements

* Add `prepend_before` and `append_after` hooks (preethiramdev)
    * intended for extension libs
    * restores rspec-1 behavior
* Reporting of profiled examples (moro)
    * Report the total amount of time taken for the top slowest examples.
    * Report what percentage the slowest examples took from the total runtime.

Bug fixes

* Properly parse `SPEC_OPTS` options.
* `example.description` returns the location of the example if there is no
  explicit description or matcher-generated description.
* RDoc fixes (Grzegorz Świrski)
* Do not modify example ancestry when dumping errors (Michael Grosser)

### rspec-expectations-2.10.0

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.9.1...v2.10.0)

Enhancements

* Add new `start_with` and `end_with` matchers (Jeremy Wadsack)
* Add new matchers for specifying yields (Myron Marson):
    * `expect {...}.to yield_control`
    * `expect {...}.to yield_with_args(1, 2, 3)`
    * `expect {...}.to yield_with_no_args`
    * `expect {...}.to yield_successive_args(1, 2, 3)`
* `match_unless_raises` takes multiple exception args

Bug fixes

* Fix `be_within` matcher to be inclusive of delta.
* Fix message-specific specs to pass on Rubinius (John Firebaugh)

### rspec-mocks-2.10.0

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.9.0...v2.10.0)

Bug fixes

* fail fast when an `exactly` or `at_most` expectation is exceeded 

### rspec-rails-2.10.0

[full changelog](http://github.com/rspec/rspec-core/compare/v2.9.0...v2.10.0)

Bug fixes

* `render_views` called in a spec can now override the config setting. (martinsvalin)
* Fix `render_views` for anonymous controllers on 1.8.7. (hudge, mudge)
* Eliminate use of deprecated `process_view_paths`
* Fix false negatives when using `route_to` matcher with `should_not`
* `controller` is no longer nil in `config.before` hooks
* Change `request.path_parameters` keys to symbols to match real Rails
  environment (Nathan Broadbent)
* Silence deprecation warnings in pre-2.9 generated view specs
  (Jonathan del Strother)

