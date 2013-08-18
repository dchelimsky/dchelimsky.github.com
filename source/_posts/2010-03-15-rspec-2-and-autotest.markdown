---
author: David
comments: true
date: 2010-03-15 11:59:15+00:00
layout: post
slug: rspec-2-and-autotest
title: rspec-2 and autotest
wordpress_id: 2621
categories:
- Autotest
- RSpec
---

[Updated on 17 March, 2010]

I just released rspec-2.0.0.beta.4 with support for `autotest`, among other enhancements. Autotest integration is going to be a bit different in rspec-2. We're removing the `autospec` command, which did nothing but set an environment variable and call `autotest`.

In rspec-2, you'll use the `autotest` command directly, but doing so requires a small bit of configuration. As of beta.4, you'll have to do add this configuration manually. Just create an `autotest` directory in the root of your project, put the following statement in `./autotest/discover.rb`:


    
    
    Autotest.add_discovery { "rspec2" }
    



The final 2.0.0 release will include a generator (even for non-rails projects) that will add this for you.
