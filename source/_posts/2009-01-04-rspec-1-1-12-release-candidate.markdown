---
author: David
comments: false
date: 2009-01-04 21:53:00+00:00
layout: post
slug: rspec-1-1-12-release-candidate
title: rspec-1.1.12 release candidate
wordpress_id: 1950
---

I'm getting ready to do a 1.1.12 release of rspec and rspec-rails. Given the history of release-related compatibility problems, I offer you release candidate gems, which you can acquire thusly:





UPDATE: new version (1.1.11.6) fixes dependency problem w/ github gems




    
    <code>gem sources --add http://gems.github.com
    [sudo] gem install dchelimsky-rspec -v 1.1.11.6
    [sudo] gem install dchelimsky-rspec-rails -v 1.1.11.6
    </code>





Release notes can be seen under Maintenance at:







  * [http://github.com/dchelimsky/rspec/tree/master/History.txt](http://github.com/dchelimsky/rspec/tree/master/History.txt)


  * [http://github.com/dchelimsky/rspec-rails/tree/master/History.txt](http://github.com/dchelimsky/rspec-rails/tree/master/History.txt)





NOTE: This will be the last release of rspec-rails that supports rails < 2.0





If you are so inclined, please grab these gems, use them, and [let me
know if there are any problems](http://rspec.lighthouseapp.com/projects/5645-rspec).
