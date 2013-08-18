---
author: David
comments: true
date: 2009-09-15 01:00:15+00:00
layout: post
slug: rspec-129rc1-and-rspec-rails-129rc1-have-been-released
title: rspec-1.2.9.rc1 and rspec-rails-1.2.9.rc1 have been released
wordpress_id: 2584
categories:
- RSpec
- Rails
---

## release candidates

We’re using the new rubygems prerelease feature to do proper release candidates. This feature was introduced to rubygems a couple of versions back, but I’d recommend updating to rubygems-1.3.5 before installing the rspec prerelease gems.

For those unfamiliar with this new rubygems feature, you have to add the --prerelease flag in order to see and install these gems:

    $ gem search --remote --prerelease rspec

      *** REMOTE GEMS ***

      rspec (1.2.9.rc1)
      rspec-rails (1.2.9.rc1)

    $ [sudo] gem install --prerelease rspec
    $ [sudo] gem install --prerelease rspec-rails

This way only those who choose to install the prerelease gems will get them, while those who exclude the –prerelease flag will get the previous final release (rspec-1.2.8, rspec-rails-1.2.7.1).

Once you install the prerelease gems, Rubygems will treat 1.2.9.rc1 as a higher version than 1.2.8, but a lower version than 1.2.9. That way when we do the final release you’ll be able to just install 1.2.9 and it will take its rightful place ahead of 1.2.9.rc1 without you having to uninstall rc1.
