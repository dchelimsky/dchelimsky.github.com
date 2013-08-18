---
author: David
comments: true
date: 2011-07-18 13:15:26+00:00
layout: post
slug: stop-typing-bundle-exec
title: Stop typing "bundle exec"
wordpress_id: 2818
categories:
- Ruby
---

[Bundler](http://gembundler.com/) serves two primary purposes:

1. it helps you to install the correct gem versions
2. it constrains the load path to the correct gem versions at runtime

Assuming you're using Bundler to constrain your runtime environment (which you
are if you're using Rails 3 defaults), then you are likely prefixing most shell
commands with `bundle exec`.

### We interrupt this post for an important update:

Two important pieces of information in the comments:

1.  Prepending `./bin` to your path exposes a serious security risk. Proceed with caution.
2.  [rvm >= 1.6.18 + bundler >= 1.0.5 removes the need for this altogether](http://beginrescueend.com/integration/bundler/).

### We now return you to our regularly scheduled post:

Here's a little tip to help save you the prefix, without adding any aliases or
functions to your environment.


    
    
    bundle install --binstubs
    export PATH=./bin:$PATH
    



`bundle install --binstubs` creates a `bin` directory at the root of your
project, and fills it with Bundler-enabled wrappers for all of the executables
installed by the gems listed in your Gemfile. This enables you to type
`bin/rake` instead of `bundle exec rake`, for example, ensuring that the
correct version of rake is loaded.

Now prepend `./bin` to your path and you can just type `rake`.


