---
author: David
comments: false
date: 2007-02-01 00:50:34+00:00
layout: post
slug: specs-and-assertions-together-again-at-last
title: expectations and assertions, together again at last
wordpress_id: 17
---

Unlike rspec core, 'spec/rails', a.k.a. rspec_on_rails, wraps 'test/unit' in order to take advantage of facilities that are tightly coupled to 'test/unit' (e.g. fixtures).






One thing that's been missing, however, has been the ability to just use 'test/unit' assertions right in your specs. With the upcoming 0.8 release (anything after rev 1451 if you're a trunkster), you'll now be able to do so.






This means that, in theory, you'll have access to all of the plugins that are available that are bound to 'test/unit', like [form_test_helper](http://www.jasongarber.com/articles/2006/10/24/easier-testing-of-forms-form_test_helper) and the [hpricot_test_extension](http://lukeredpath.co.uk/2006/7/7/testing-your-rails-views-with-hpricot).






I say "in theory" because it is impossible for us to commit to support all of the existing plugins any more than any plugin developer can commit to supporting compatibility with all other plugins. That said, I've tried both of the plugins mentioned above and they "just worked".
