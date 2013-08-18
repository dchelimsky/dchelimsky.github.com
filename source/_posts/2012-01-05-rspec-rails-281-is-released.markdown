---
author: David
comments: true
date: 2012-01-05 05:43:28+00:00
layout: post
slug: rspec-rails-281-is-released
title: rspec-rails-2.8.1 is released
wordpress_id: 2863
categories:
- BDD
- RSpec
- Rails
- Ruby
---

## Bug fix release

The rails-3.2.0.rc2 release broke `stub_model` in rspec-rails-2.0.0 > 2.8.0.
The rspec-rails-2.8.1 release fixes this issue, but it means that when you
upgrade to rails-3.2.0.rc2 or greater, you'll have to upgrade to
rspec-rails-2.8.1 or greater.

Because rspec-rails-2.8.1 supports all versions of rails since 3.0, I recommend
that you upgrade to rspec-rails-2.8.1 first, and then upgrade to
rails-3.2.0.rc2 (or 3.2.0 once it's out).

### Changelog

[http://rubydoc.info/gems/rspec-rails/file/Changelog.md](http://rubydoc.info/gems/rspec-rails/file/Changelog.md)

### Docs

[http://rubydoc.info/gems/rspec-rails](http://rubydoc.info/gems/rspec-rails)
  

[http://relishapp.com/rspec/rspec-rails](http://relishapp.com/rspec/rspec-rails)

