---
author: David
comments: true
date: 2010-10-15 14:30:15+00:00
layout: post
slug: rspec-rails-201-is-released
title: rspec-rails-2.0.1 is released!
wordpress_id: 2689
categories:
- RSpec
- Rails
---

The rails-3.0.1 release excluded a change that I had naively expected to be included. This upgrade is only necessary if you write view specs and are upgrading to rails-3.0.1. To upgrade, all you need to do is change your Gemfile to read:

    gem "rspec-rails", "2.0.1"

And then run

	bundle update rspec-rails

## Release Notes

### 2.0.1 / 2010-10-15

[full changelog](http://github.com/rspec/rspec-rails/compare/v2.0.0...v2.0.1)

* Enhancements
  * Add option to not generate request spec (--skip-request-specs)

* Bug fixes
  * Updated the mock_[model] method generated in controller specs so it adds
    any stubs submitted each time it is called.
  * Fixed bug where view assigns weren't making it to the view in view specs in Rails-3.0.1.
    (Emanuele Vicentini)

