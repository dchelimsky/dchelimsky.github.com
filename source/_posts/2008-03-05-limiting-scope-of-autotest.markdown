---
author: David
comments: false
date: 2008-03-05 07:07:48+00:00
layout: post
slug: limiting-scope-of-autotest
title: limiting scope of autotest
wordpress_id: 59
categories:
- Autotest
---

If you use [autotest](http://zentest.rubyforge.org/ZenTest/classes/Autotest.html) with [rspec](http://rspec.info) or test/unit, you've probably had this experience (or one like it):






You want to add some new behaviour to a model object, so you write a spec, watch it fail, make it pass, and then wait until the entire spec suite runs. Even if you've got a fast-running suite, this can be painful sometimes.






Wouldn't it be great if you could limit the scope of what directories autotest observes?  Well it turns out that you can! Recent releases of ZenTest include a find_directories attribute on the autotest object. Just add this to your .autotest file:





    
    
    Autotest.add_hook :initialize do |at|
    unless ARGV.empty?
      at.find_directories = ARGV.dup
    end
    end
    





and then you can say:




    
    
    autotest app/models spec/models
    





and it will only observe those directories. This is nice and flexible, but I find that most of the time I'm wanting pairs like that: app/models and spec/models, or app/views/accounts and spec/views/accounts. In that case, I'd really like to just say:





    
    
    autotest models
    





To accomplish that you can do this to the hook instead:





    
    
    Autotest.add_hook :initialize do |at|
    unless ARGV.empty?
      at.find_directories = ["spec/#{ARGV.first}","app/#{ARGV.first}"]
    end
    end
    





Want the best of both worlds? Try this:




    
    
    Autotest.add_hook :initialize do |at|
    unless ARGV.empty?
      at.find_directories = ARGV.length == 1 ? ["spec/#{ARGV.first}","app/#{ARGV.first}"] : ARGV.dup
    end
    end
    





The only limitation of this is that it's based on directories, not files. Once in a while, when I'm bootstrapping a new object, I'll keep the examples and the implementation in the same file until I've got things fleshed out a bit the object is ready to play nice with others. In that case, I might like to just point autotest to that one file. I started working on a patch for this for ZenTest, but I'm not sure it's worth the extra effort. What do you think?






Regardless - happy auto-exemplifying!
