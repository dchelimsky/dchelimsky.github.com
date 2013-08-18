---
author: David
comments: true
date: 2010-07-11 12:48:59+00:00
layout: post
slug: rspec-rails-2-generators-and-rake-tasks
title: rspec-rails-2 generators and rake tasks
wordpress_id: 2649
categories:
- RSpec
- Rails
tag:
- rails-3
- rspec-2
---

As of [rspec-rails-2.0.0.beta.17](http://github.com/rspec/rspec-rails), generators and rake tasks are exposed through a [Railtie](http://github.com/rspec/rspec-rails/blob/master/lib/rspec-rails.rb). In order to see them when you run `rails generate` and `rake -T`, you need to include the `rspec-rails` gem in the `:development` group in your `Gemfile`.


    
    
    group :development, :test do
    gem "rspec-rails", ">= 2.0.0.beta.17"
    end
    



If you have a previous version of `rspec-rails-2.0.0.beta` installed, you should also remove these files:


    
    
    lib/tasks/rspec.rake
    config/initializers/rspec_generator.rb
    
