---
author: David
comments: true
date: 2011-02-06 17:25:04+00:00
layout: post
slug: rspec-core-251-is-released
title: rspec-core-2.5.1 is released!
wordpress_id: 2744
categories:
- BDD
- RSpec
---

### rspec-core-2.5.1

[full changelog](http://github.com/rspec/rspec-core/compare/v2.5.0...v2.5.1)

#### This release breaks compatibility with rspec/autotest/bundler integration, but does so in order to greatly simplify it.

With the release of rspec-core-2.5.1, if you want the generated autotest command to include `bundle exec`, require Autotest's bundler plugin in a `.autotest` file in the project's root directory or in your home directory:

    require "autotest/bundler"

Now you can just type 'autotest' on the commmand line and it will work as you expect.

If you don't want 'bundle exec', there is nothing you have to do.

