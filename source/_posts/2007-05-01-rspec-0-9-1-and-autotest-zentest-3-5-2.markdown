---
author: David
comments: false
date: 2007-05-01 13:27:21+00:00
layout: post
slug: rspec-0-9-1-and-autotest-zentest-3-5-2
title: RSpec-0.9.1 and Autotest (ZenTest-3.5.2)
wordpress_id: 27
---

[Autotest](http://zentest.rubyforge.org/ZenTest/classes/Autotest.html) (part of [ZenTest](http://zentest.rubyforge.org)) now supports [RSpec](http://rspec.rubyforge.org). This is fantastic news! For those of you who do not know about autotest, it is a program that runs in the background while you are writing your tests and code. Each time you make a change it automatically reruns your tests - and now your specs, too! This is a powerful addition to the TDD/BDD experience.






Recent releases of both tools overlapped a bit so there are changes in [RSpec-0.9.1](http://rubyforge.org/frs/shownotes.php?release_id=11423) that are not reflected yet in ZenTest. Also, while ZenTest-3.5.2 supports [Spec::Rails](http://rspec.rubyforge.org/documentation/rails/index.html), RSpec's [Ruby on Rails](http://rubyonrails.com) plugin, it does not support non-Rails Ruby projects.






I've submitted a patch to the ZenTest project which addresses both of these issues. Until the patch is applied, or the issues are addressed in some other way, you can apply it yourself to get autotest working with RSpec for Rails and other projects. These steps work on a mac. I assume that the commands are quite similar for Linux and Cygwin users.








  1. Go to http://rubyforge.org/frs/?group_id=419 and download ZenTest-3.5.2.tgz


  2. Unpack the tar and

    
    tar zxvf ZenTest-3.5.2.tgz
    cd ZenTest-3.5.2
    





  3. Get and install the patch

    
    curl -O http://blog.davidchelimsky.net/files/ZenTest-3.5.2-rspec.patch
    patch -p0 < ZenTest-3.5.2-rspec.patch
    





  4. Build and install the gem

    
    rake gem
    sudo gem install pkg/ZenTest-3.5.2.gem
    






Once you've built and installed the patched gem, you run autotest as normal. Stand in the root of your project and say:





    
    autotest





If you have a `spec` directory at the root of your project, autotest will load up rspec_rails_autotest for Rails projects and rspec_autotest for everything else.






To quote [Josh Knowles](http://joshknowles.com/2007/4/13/zentest-3-5-rspec-0-9-autospec), Happy (Auto)Specing!
