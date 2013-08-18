---
author: David
comments: true
date: 2010-06-28 03:01:40+00:00
layout: post
slug: view-isolation-in-rspec-rails-2
title: View isolation in rspec-rails-2
wordpress_id: 2643
tag:
- Rails
- rspec-2
---

View isolation is changing in [rspec-rails-2](http://github.com/rspec/rspec-rails). As of [beta.14](http://rubygems.org/gems/rspec-rails/versions/2.0.0.beta.14.1), _the view template needs to exist_, but the content of the template will not be evaluated. This still provides isolation from the content of the template and its dependencies, it just means the file has to be there, which means you have to create it.

## Why this change?

rspec-rails-1 performed some [serious gymnastics](http://github.com/dchelimsky/rspec-rails/blob/master/lib/spec/rails/example/controller_example_group.rb) to isolate controller specs from views. As many rspec/rails users well know, all the monkey patching of Rails' internals led to rspec-rails releases immediately following rails releases.

Thankfully, Rails 3 exposes very clean extension points and APIs that make it far simpler to get the most important part of this isolation: isolation from the content of the template.

## Rails 3 Resolvers

Rails makes a number of decisions based on the existence or lack thereof of a given template on the file system. Rails 3 also supports custom resolvers that let you store view templates in a database, for example. Given the wide array of possibilities, it is not possible for RSpec to predict every way in which templates will be stored or accessed.

What RSpec _can_ do, and does as of beta.14, is use the Rails machinery, or custom extensions that adhere to the Rails Resolver API, to find and load templates, and then stub out the content. Doing so requires [much less code](http://github.com/rspec/rspec-rails/blob/master/lib/rspec/rails/view_rendering.rb) and, more importantly, much less invasive code. This increases the likelihood that new features in Rails will _just work_ with rspec-rails as it is, and decreases the likelihood that changes to Rails' internals will require rspec-rails to release updates with every new release of Rails.


