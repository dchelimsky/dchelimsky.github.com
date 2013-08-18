---
author: David
comments: false
date: 2008-02-04 08:04:57+00:00
layout: post
slug: rspec-1-1-3-and-zentest-3-9-1
title: RSpec-1.1.3 and ZenTest-3.9.1
wordpress_id: 57
---

ZenTest's last two releases are not compatible with previous versions of RSpec. This is **good news** because Autotest now exposes better extension points for subclasses like those that ship with RSpec. Before, RSpec had to monkey patch Autotest to control the mappings of specs to files to run, and the list of files/directories to ignore. Now RSpec gets to use public methods (instead of instance variables) and documented hooks to do it's work.






In the long run, this will keep things more flexible for both RSpec and ZenTest. In the short run, the catch for you is that you have to use compatible versions of RSpec and ZenTest. They are:










  RSpec versionZenTest version


  


    
<= 1.1.1
<= 3.7.x

  
  


    
1.1.2
3.8.x

  
  


    
1.1.3
3.9.x

  


