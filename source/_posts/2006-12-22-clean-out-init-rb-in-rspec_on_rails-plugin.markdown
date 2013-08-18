---
author: David
comments: false
date: 2006-12-22 22:24:46+00:00
layout: post
slug: clean-out-init-rb-in-rspec_on_rails-plugin
title: clean out init.rb in rspec_on_rails plugin
wordpress_id: 6
---

There is a conflict between spec/rails and test/unit that prevents you from running tests if specs are loaded up. Previous versions of spec/rails had require statements in init.rb in the plugin's root directory. This meant that you were ALWAYS loading rspec, even in your dev and production environments.






The current version (0.7.5) relies on ~/spec/spec_helper.rb to require 'spec/rails', and init.rb is empty.






If you are working with any previous versions, be sure to clean out your ~/vendor/plugins/rspec_on_rails/init.rb (some versions had that directory as rspec).
