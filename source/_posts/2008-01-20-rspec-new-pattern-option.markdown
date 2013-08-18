---
author: David
comments: false
date: 2008-01-20 18:01:04+00:00
layout: post
slug: rspec-new-pattern-option
title: 'RSpec: new --pattern option'
wordpress_id: 55
---

Updated on 27 May, 2008






I'm not in the habit of blogging every change we make to RSpec, but this one **may** change the way your suite behaves if you have not been following convention.






As of RSpec's trunk revision 3246 there is a new command line option that lets you control the filename pattern to match. This allows you to restrict files that are loaded when running the spec command in the same way that you can with rake. It also means that helper files that you may depend on are no longer loaded implicitly.






The default is:





    
    <code>"spec/**/*_spec.rb".
    </code>





To get rspec to behave as it did before this change, use this:





    
    <code>--pattern "spec/**/*.rb"
    </code>





If you prefer naming your spec files "foo_example.rb", you can do this:





    
    <code>--pattern "spec/**/*_example.rb"
    </code>





You can also supply multiple patterns (comma separated):





    
    <code>--pattern "spec/**/*_example.rb, spec/**/*_spec.rb"
    </code>





This is a very handy way to avoid loading resource files (helpers, matchers, etc) except when you require them explicitly from other files.






This is currently only in trunk, but will be part of the next release.
