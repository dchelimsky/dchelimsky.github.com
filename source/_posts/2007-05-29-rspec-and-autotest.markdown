---
author: David
comments: false
date: 2007-05-29 13:19:11+00:00
layout: post
slug: rspec-and-autotest
title: rspec and autotest
wordpress_id: 32
---

At [RailsConf 2007](http://conferences.oreillynet.com/rails/) in Portland, I had the privilege of sitting down w/ [Ryan Davis](http://zenspider.com) and working with him to improve the runtime relationship between [RSpec](http://rspec.rubyforge.org) and [Autotest](http://zentest.rubyforge.org/ZenTest/). David Goodlad was at the table as well, and helped me work out some of the mappings so autotest runs the right examples when you change application code.






The result is that with RSpec >= 1.0.3 and ZenTest >= 3.6.0, you can now use Autotest with RSpec on your Ruby projects, Rails or otherwise, simply by typing "autotest" in the project root. No additional plugins necessary. Sweet.






One gotcha: Some have reported that when an example fails, autotest keeps running it over and over again until you get it to pass. This is due to a conflict between RSpec's and autotest's mechanisms for narrowing down the set of files to run. This is easily resolved by removing the following lines from spec/spec.opts:





    
    
    --format
    failing_examples:previous_failures.txt
    --example
    previous_failures.txt
    





If you run 'script/generate rspec', these lines will not be included in the generated spec.opts file. Otherwise you can just delete them yourself.
