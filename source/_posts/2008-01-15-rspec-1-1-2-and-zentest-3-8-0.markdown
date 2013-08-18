---
author: David
comments: false
date: 2008-01-15 06:15:55+00:00
layout: post
slug: rspec-1-1-2-and-zentest-3-8-0
title: RSpec-1.1.2 and ZenTest-3.8.0
wordpress_id: 54
categories:
- Autotest
- RSpec
---

The [RSpec-1.1.2](http://rspec.info) release includes changes to keep RSpec compatible with autotest in [ZenTest-3.8.0](http://zentest.rubyforge.org/ZenTest/). This new ZenTest release boasts an improved cascading configuration model that works well for subclasses (like those that ship with RSpec) **and** allows users to override the mappings of specs (or tests) to code as well as the list of files that get ignored by autotest.





To support this, Autotest now loads the following files in the following order:




    
    
    Autotest
    AutotestSubClass
    ~/.autotest
    ./.autotest
    





This allows RSpec (or any other library) to override defaults set in `Autotest`, and then provides users both generic (~/.autotest) and project specific (./.autotest) control over the mappings and exceptions.





How can you take advantage of this?





When autotest begins to run, it calls its `:initialize` hook. This hook is exposed by the `add_hook` method. You can use this to access the mappings and exceptions using the following methods on Autotest:




    
    
    clear_mappings()
    add_mapping(regexp, proc)
    remove_mapping(regexp)
    
    clear_exceptions()
    add_exception(string)
    remove_exception(string)
    





#### add_mapping





The `add_mapping` method adds a key/value pair to a hash that maps regexps to procs. Whenever autotest senses that a file is touched, it looks for the regexp that matches the file name and the runs all the files returned by the associated proc.





Imagine you're working on a shopping cart app. You have some currency conversion behaviour in a `Product` model that you'd like to extract to an `acts_as_currency` plugin, and you want autotest to observe the process. You might add a mapping like this to .autotest:




    
    
    Autotest.add_hook :initialize do |at|
    at.add_mapping(%r%^plugins/acts_as_currency/lib/.*\.rb$%) {
      at.files_matching %r%^spec/models/product_spec\.rb$% +
      at.files_matching %r%^plugins/acts_as_currency/spec/.*_spec\.rb$%
    }
    end
    





In this case, a change to any of the files in the plugin's lib directory would cause all the plugins specs to run, as well as the spec for the `Product` model.





#### add_exception





The `add_exception` method adds paths to a list of paths that Autotest ignores.





I like to run autotest in verbose mode (`autotest -v`) because it tells me when I change a file that it doesn't know what to do with. The drawback is that it wants to tell me every time I commit because files in the .svn/.hg/.git directories change. So I've got these all listed as exceptions in my ~/.autotest file, along with assorted others:




    
    
    Autotest.add_hook :initialize do |at|
    %w{.svn .hg .git}.each {|exception|at.add_exception(exception)}
    end
    





Note that autotest compiles this list to a Regexp with no anchors, so .hgignore and .gitignore would also get ignored in this case.





#### Cascading config and granular control





One of the coolest changes in ZenTest-3.8.0 is that autotest loads both ~/.autotest and ./.autotest. So now you can have the hooks you like on every project (like growl notifation) all in one place and still have project specific settings.





This also allows you to set up global mappings/exceptions and modify them at the project level. See [Autotest's RDoc](http://zentest.rubyforge.org/ZenTest/classes/Autotest.html) for more info.
