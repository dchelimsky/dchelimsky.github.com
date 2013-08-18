---
author: David
comments: true
date: 2012-05-05 06:34:08+00:00
layout: post
slug: rspec-mocks-and-rspec-rails-2101-are-released
title: rspec-mocks and rspec-rails-2.10.1 are released!
wordpress_id: 2914
---

These are patch releases recommended for anybody who has already upgraded to 2.10.

### rspec-mocks-2.10.1
[full changelog](http://github.com/rspec/rspec-mocks/compare/v2.10.0...v2.10.1)

Bug fixes

* fix [regression of edge case behavior](https://github.com/rspec/rspec-mocks/issues/132)
    * fixed failure of `object.should_receive(:message).at_least(0).times.and_return value`
    * fixed failure of `object.should_not_receive(:message).and_return value`

### rspec-rails-2.10.1
[full changelog](http://github.com/rspec/rspec-rails/compare/v2.10.0...v2.10.1)

Bug fixes

* fix [regression introduced in 2.10.0 that broke integration with Devise](https://github.com/rspec/rspec-rails/issues/534)


