---
author: David
comments: true
date: 2010-11-29 19:21:29+00:00
layout: post
slug: rspec-221-is-released
title: rspec-core-2.2.1 is released!
wordpress_id: 2714
categories:
- BDD
- RSpec
---

### 2.2.1 / 2010-11-28

[full changelog](http://github.com/rspec/rspec-core/compare/v2.2.0...v2.2.1)

* Bug fixes
  * alias_method instead of override Kernel#method_missing (John Wilger)
  * changed --autotest to --tty in generated command (MIKAMI Yoshiyuki) 
  * revert change to debugger (had introduced conflict with Rails)
    * also restored --debugger/-debug option

