---
author: David
comments: false
date: 2007-05-31 22:37:35+00:00
layout: post
slug: web_spec-ghost-of-spec-ui-past
title: 'web_spec: ghost of spec:ui past'
wordpress_id: 33
---

[Ryan Davis](http://blog.zenspider.com/) just [posted about a problem he helped to diagnose](http://blog.zenspider.com/archives/2007/05/autotestrspecrubygems_problems.html) that relates back to an earlier version of Spec::Ui (which ships with RSpec).






The first version of Spec:Ui was called web_spec, and it (unfortunately and erroneously) got installed as a gem when you installed RSpec 0.7.5.






If you have this in your gems directory, kindly send it on its merry way. It's broken, and will break your stuff (read [Ryan's blog post](http://blog.zenspider.com/archives/2007/05/autotestrspecrubygems_problems.html) for details).
