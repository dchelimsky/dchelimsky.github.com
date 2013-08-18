---
author: David
comments: true
date: 2010-01-12 04:12:27+00:00
layout: post
slug: rspec-2-and-rails-3
title: Rspec 2 and Rails 3
wordpress_id: 2607
categories:
- RSpec
- Rails
---

With the beta release of [Rails](http://rubyonrails.org) 3 just around the corner, we're planning a 2.0 release of [Rspec](http://rspec.info), with an rspec-rails-2.0 gem for rails-3.0.

Late last week and through the weekend, [Engine Yard](http://engineyard.com), [Relevance](http://thinkrelevance.com) and [Obtiva](http://obtiva.com) sponsored a meeting with [Yehuda Katz](http://yehudakatz.com/), [Carl Lerche](http://carllerche.com/), [Chad Humphries](http://spicycode.com/), and me. The four of us laid out some groundwork and made some good progress toward what promises to be be a very friendly world for Rspec and Rails users and extenders. 

Thanks to [David Heinemeier Hansson](http://www.loudthinking.com) and the rest of the [Rails core team](http://rubyonrails.org/core) for embracing agnosticism without compromising convention over configuration.

I'll follow up with details as things shape up, but here is a quick synopsis:

### Rails users

Whether or not you use Rspec, you'll see improvements in some of the built-in assertions, and other testing facilities that ship with Rails.

### Rspec-rails users

If you do use Rspec, you'll see a new rspec-rails plugin/gem that hooks into new features of rails-3 like the new rails generators. You'll also see support for Merb-style request specs that wrap Rails' integration tests.

### Test framework authors

Rails' testing APIs will be decoupled from the Test::Unit and Minitest runners. For authors of new testing frameworks, this means that you'll be able to include a module in your framework's objects instead of having to subclass `TestCase`. This will make it much easier to experiment with new ideas in the context of Rails, which clearly exposes those ideas to a wider audience than otherwise.

