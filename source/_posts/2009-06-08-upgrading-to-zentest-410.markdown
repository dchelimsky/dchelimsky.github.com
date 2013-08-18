---
author: David
comments: true
date: 2009-06-08 01:17:36+00:00
layout: post
slug: upgrading-to-zentest-410
title: Upgrading to ZenTest 4.1.0
wordpress_id: 2507
---

If you use [Autotest](http://zentest.rubyforge.org/ZenTest/Autotest.html) with [Ruby on Rails](http://rubyonrails.org/), be sure to `gem install autotest-rails` when you upgrade to [ZenTest-4.1.0](http://blog.zenspider.com/2009/06/zentest-version-410-has-been-r.html).

Without that gem, when you run the `autospec` command that ships with [RSpec](http://rspec.info), Autotest won't won't have any way of knowing it's in a Rails app and it will load up [rspec](http://github.com/dchelimsky/rspec)'s `autotest/rspec.rb` instead of [rspec-rails](http://github.com/dchelimsky/rspec-rails)' `autotest/rails_rspec.rb`.

Even if you're not using [RSpec](http://rspec.info), you'll get ZenTest's `autotest/autotest.rb` instead of `autotest/rails.rb` when you run the `autotest` command.

The next release of [rspec-rails](http://github.com/dchelimsky/rspec-rails) will include a [patch](http://github.com/dchelimsky/rspec-rails/commit/0c23da7ef00d2428c3eb9aa1956d3fd1a1020ffb) to resolve this for RSpec users, but in the mean time (and for everybody else), just `gem install autotest-rails` and resume your regularly scheduled continuous testing.
