---
author: David
comments: true
date: 2010-09-13 02:23:23+00:00
layout: post
slug: rspec-200beta22-is-released
title: RSpec-2.0.0.beta.22 is released!
wordpress_id: 2674
categories:
- BDD
- RSpec
- Rails
---

We're getting very close to a 2.0 release candidate, so if you're not already using rspec-2 (with or without rails-3), now is the time to start. I need your feedback, so from here on in I'll be sending out announcements and release notes for each beta release.

As for rspec-2 with rails-2, there are a few efforts underway to make that work, but that will be in the form of a separate gem and our priority is getting rspec-2 out the door.

Please report issues or submit pull requests (yes, pull requests are fine now that github has integrated them so well with issues) to the appropriate repos:

* [http://github.com/rspec/rspec-core/issues](http://github.com/rspec/rspec-core/issues)
* [http://github.com/rspec/rspec-expectations/issues](http://github.com/rspec/rspec-expectations/issues)
* [http://github.com/rspec/rspec-mocks/issues](http://github.com/rspec/rspec-mocks/issues)
* [http://github.com/rspec/rspec-rails/issues](http://github.com/rspec/rspec-rails/issues)

Here are release notes for each gem in this beta release, drawn from the nascent History.md files in each project.

#### rspec-core-2.0.0.beta.22 / 2010-09-12

[full changelog](http://github.com/rspec/rspec-core/compare/v2.0.0.beta.20...v2.0.0.beta.22)

* Enhancements
  * removed at_exit hook
  * CTRL-C stops the run (almost) immediately
    * first it cleans things up by running the appropriate after(:all) and after(:suite) hooks
    * then it reports on any examples that have already run
  * cleaned up rake task
    * generate correct task under variety of conditions
    * options are more consistent
    * deprecated redundant options
  * run 'bundle exec autotest' when Gemfile is present
  * support ERB in .rspec options files (Justin Ko)
  * depend on bundler for development tasks (Myron Marston)
  * add example_group_finished to formatters and reporter (Roman Chernyatchik)

* Bug fixes
  * support paths with spaces when using autotest (Andreas Neuhaus)
  * fix module_exec with ruby 1.8.6 (Myron Marston)
  * remove context method from top-level
    * was conflicting with irb, for example
  * errors in before(:all) are now reported correctly (Chad Humphries)

* Removals
  * removed -o --options-file command line option
    * use ./.rspec and ~/.rspec

#### rspec-expectations-2.0.0.beta.22 / 2010-09-12

[full changelog](http://github.com/rspec/rspec-expectations/compare/v2.0.0.beta.20...v2.0.0.beta.22)

* Enhancements
  * diffing improvements
    * diff multiline strings
    * don't diff single line strings
    * don't diff numbers (silly)
    * diff regexp + multiline string

* Bug fixes
  * should[_not] change now handles boolean values correctly

#### rspec-mocks-2.0.0.beta.22 / 2010-09-12

[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.0.0.beta.20...v2.0.0.beta.22)

* Bug fixes
  * fixed regression that broke obj.stub_chain(:a, :b => :c)
  * fixed regression that broke obj.stub_chain(:a, :b) { :c }
  * respond_to? always returns true when using as_null_object

#### 2.0.0.beta.22 / 2010-09-12

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.0.0.beta.20...v2.0.0.beta.22)

* Enhancements
  * autotest mapping improvements (Andreas Neuhaus)

* Bug fixes
  * delegate flunk to assertion delegate


