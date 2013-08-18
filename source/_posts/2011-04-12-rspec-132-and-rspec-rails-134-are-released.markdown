---
author: David
comments: true
date: 2011-04-12 03:59:10+00:00
layout: post
slug: rspec-132-and-rspec-rails-134-are-released
title: rspec-1.3.2 and rspec-rails-1.3.4 are released!
wordpress_id: 2766
---

rspec-1.3.2 and rspec-rails-1.3.4 have been released!

This is primarily a bug-fix release of the rspec-1.x series, and is recommended for all users who have not yet upgraded to rspec-2.

rspec-rails-1.3 users will need to upgrade to rspec-rails-1.3.4, which depends on rspec ~> 1.3.2 (meaning 1.3.2 and up, but not 2.0).

### rspec 1.3.2

* Enhancements
 * Raise a meaningful error when an argument-scoped stub is called with the
   wrong args (Alexey)
 * Dev: ignore .rbc files (Myron Marston)

* Bug fixes
 * Fix regression in which an expectation should return the value from a
   previously defined stub of the same method (Tom Stuart)
 * Support heckling class methods (Dan Kubb)
 * Only try to pass messages to the superclass if the superclass responds to
   the method (Andrew Selder)

rspec-rails-1.3.4 is released!

### rspec-rails 1.3.4

* No new code
* Depends on rspec ~> 1.3.2
 * rspec-rails 1.3.3 depended on rspec-1.3.1 explicitly, so this
   release allows you to upgrade to rspec-1.3.2 with rspec-rails.


