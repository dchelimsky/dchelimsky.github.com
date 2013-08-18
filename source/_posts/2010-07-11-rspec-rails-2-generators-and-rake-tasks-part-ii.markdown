---
author: David
comments: true
date: 2010-07-11 22:41:10+00:00
layout: post
slug: rspec-rails-2-generators-and-rake-tasks-part-ii
title: rspec-rails-2 generators and rake tasks - part II
wordpress_id: 2653
tag:
- generators
- rails-3
- rake tasks
- rspec-2
---

Some questions have come up since I posted about [rspec-rails-2 generators and rake tasks](http://blog.davidchelimsky.net/2010/07/11/rspec-rails-2-generators-and-rake-tasks) requiring that rspec-rails be declared in the `:development` group in a Gemfile. Here are a few of them, paraphrased, with answers:

### Why the change?

rspec-rails now uses a Railtie to expose the rake tasks and generators. Railties allow Rails extensions to register themselves with Rails without having to copy files into your app. This makes installation and, especially, upgrades much easier to manage for both maintainers and users.

### Do I need rspec-rails in both :development and :test groups?

#### :development

We need rspec-rails in the `:development` group in order to expose the rake tasks and generators without having to type `RAILS_ENV=test` when we want to use them.

#### :test

Quite ironically, it turns out that we don't need it in the :test group at all. That may change in the future, and I don't see any harm in keeping it in the :test group as well, so I'll probably keep it there in my apps.

### Doesn't that mean I'm loading rspec-rails and all of its dependencies in the :development environment?

No, and herein lies the benefit of using a Railtie for this.

When you declare a gem in a Gemfile, Bundler loads up a file with the same name as the gem, in our case [`rspec-rails.rb`](http://github.com/rspec/rspec-rails/blob/master/lib/rspec-rails.rb).

<script src="http://gist.github.com/471892.js?file=rspec-rails.rb"></script>

The generator configs are only invoked when running `rails generate`, which is when you want them.  The `require` statement is only invoked when running `rake`, which is when you want it. If you're not running `rake` or `rails generate`, then no other files from rspec-rails or any of its dependencies are loaded, _unless you load them explicitly from elsewhere in your app_.

### Does this actually work? When I add rspec-rails to the :development group and run `rails generate`, I don't see most of the rspec generators.

The only RSpec generator that is intended to be invoked directly is `rspec:install`, which you'll still see. The others are invoked implicitly by Rails when you run the various Rails generators. e.g., if you run `script/rails generate controller Widgets`, the controller generator implicitly calls out to the `rspec:controller` generator to generate a `WidgetsController` spec.

Because these are intended to be implicit, Rails hides them from you in order to reduce the noise level.

### OK, but now I see all of the `test_unit` generators. What's up with those?

Because RSpec is the test framework of record, Rails doesn't know to hide the test_unit generators. <strike>If you want to hide them, just add this to one of your config files:


    
    
    Rails::Generators.hide_namespace("test_unit")
    



</strike>

[Updated on 7//14]

Turns out that `hide_namespaces` doesn't work for this use case. I've got an [open ticket in the Rails tracker](https://rails.lighthouseapp.com/projects/8994/tickets/5111) to address this, and I'll updated this post again once it's addressed.

