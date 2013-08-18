---
author: David
comments: true
date: 2010-10-10 02:53:47+00:00
layout: post
slug: rspec-131-rspec-rails-133-are-released
title: rspec-1.3.1 / rspec-rails-1.3.3 are released
wordpress_id: 2681
---

I just released rspec-1.3.1 and rspec-rails-1.3.3.

These are mostly bug fixes that have been sitting around for all to long as I focused on rspec-2 (coming very soon).

Report issues for rspec[-rails]-1.x to [https://rspec.lighthouseapp.com/projects/5645](https://rspec.lighthouseapp.com/projects/5645).

Docs:

[http://rspec.info/](http://rspec.info/)  

[http://rdoc.info/gems/rspec/1.3.1/frames](http://rdoc.info/gems/rspec/1.3.1/frames)  

[http://rdoc.info/gems/rspec-rails/1.3.3/frames](http://rdoc.info/gems/rspec-rails/1.3.3/frames)  


Cheers,
David

### rspec-1.3.1 / 2010-10-09

* enhancements
 * Array =~ matcher works with subclasses of Array (Matthew Peychich & Pat Maddox)
 * config.suppress_deprecation_warnings!

* bug fixes
 * QuitBacktraceTweaker no longer eats all paths with 'lib'
   (Tim Harper - #912)
 * Fix delegation of stubbed values on superclass class-level methods.
   (Scott Taylor - #496 - #957)
 * Fix pending to work with ruby-1.9

* deprecations
 * share_as (will be removed from rspec-core-2.0)
 * simple_matcher (will be removed from rspec-core-2.0)

### rspec-rails-1.3.3 / 2010-10-09

* enhancements
 * replace use of 'returning' with 'tap'

* bug fixes
 * support message expectation on template.render with locals (Sergey
   Nebolsin). Closes #941.
 * helper instance variable no longer persists across examples
   (alex rothenberg). Closes #627.
 * mock_model stubs marked_for_destruction? (returns false).


