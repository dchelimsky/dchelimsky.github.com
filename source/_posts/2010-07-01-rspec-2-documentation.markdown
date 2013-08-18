---
author: David
comments: true
date: 2010-07-01 12:54:19+00:00
layout: post
slug: rspec-2-documentation
title: RSpec-2 Documentation
wordpress_id: 2647
categories:
- BDD
- RSpec
tag:
- rspec-2
---

RSpec-2 is getting close to a release candidate, and as the beta gems have been flowing a lot of questions have been coming in, especially about documentation. Here is some information that should help.

## Source code

RSpec development has moved to the [rspec](http://github.com/rspec) account on github. There are five repositories at the moment:

* [http://github.com/rspec/rspec](http://github.com/rspec/rspec)
* [http://github.com/rspec/rspec-core](http://github.com/rspec/rspec-core)
* [http://github.com/rspec/rspec-expectations](http://github.com/rspec/rspec-expectations)
* [http://github.com/rspec/rspec-mocks](http://github.com/rspec/rspec-mocks)
* [http://github.com/rspec/rspec-rails](http://github.com/rspec/rspec-rails)

[rspec-rails](http://github.com/rspec/rspec-rails) depends on [rspec](http://github.com/rspec/rspec), which depends, in turn, on the other three.

This structure has many benefits, but one cost is that the documentation, though plentiful, is a bit scattered.

## READMEs

* [http://github.com/rspec/rspec](http://github.com/rspec/rspec)
* [http://github.com/rspec/rspec-core](http://github.com/rspec/rspec-core)
* [http://github.com/rspec/rspec-expectations](http://github.com/rspec/rspec-expectations)
* [http://github.com/rspec/rspec-mocks](http://github.com/rspec/rspec-mocks)
* [http://github.com/rspec/rspec-rails](http://github.com/rspec/rspec-rails)

## Upgrade Notes

* [http://github.com/rspec/rspec-core/blob/master/Upgrade.markdown](http://github.com/rspec/rspec-core/blob/master/Upgrade.markdown)
* [http://github.com/rspec/rspec-expectations/blob/master/Upgrade.markdown](http://github.com/rspec/rspec-expectations/blob/master/Upgrade.markdown)
* [http://github.com/rspec/rspec-rails/blob/master/Upgrade.markdown](http://github.com/rspec/rspec-rails/blob/master/Upgrade.markdown)

## Cucumber features

Each of the repos has a growing set of Cucumber features. Some of the features have been added in after the fact, but many of the new features have been driven out using Cucumber. These are a great source of "How-To" information, and you _know_ they're up to date because they are _executable documentation_.

If you peruse these and are unable to find the information you're looking for, or find any of the information incomplete or confusing, please, please, please submit a github issue (see Known Issues, below). Or, better yet, submit a patch!

* [http://github.com/rspec/rspec-core/tree/master/features/](http://github.com/rspec/rspec-core/tree/master/features/)
* [http://github.com/rspec/rspec-expectations/tree/master/features/](http://github.com/rspec/rspec-expectations/tree/master/features/)
* [http://github.com/rspec/rspec-mocks/tree/master/features/](http://github.com/rspec/rspec-mocks/tree/master/features/)
* [http://github.com/rspec/rspec-rails/tree/master/features/](http://github.com/rspec/rspec-rails/tree/master/features/)

## RDoc

The RDoc is arguably the weakest link here. Patches welcome!

* [http://rdoc.info/projects/rspec/rspec-core](http://rdoc.info/projects/rspec/rspec-core)
* [http://rdoc.info/projects/rspec/rspec-expectations](http://rdoc.info/projects/rspec/rspec-expectations)
* [http://rdoc.info/projects/rspec/rspec-mocks](http://rdoc.info/projects/rspec/rspec-mocks)
* [http://rdoc.info/projects/rspec/rspec-rails](http://rdoc.info/projects/rspec/rspec-rails)

## Known Issues

Issues for rspec-2 are being maintained on github.

* [http://github.com/rspec/rspec-core/issues](http://github.com/rspec/rspec-core/issues)
* [http://github.com/rspec/rspec-expectations/issues](http://github.com/rspec/rspec-expectations/issues)
* [http://github.com/rspec/rspec-mocks/issues](http://github.com/rspec/rspec-mocks/issues)
* [http://github.com/rspec/rspec-rails/issues](http://github.com/rspec/rspec-rails/issues)

If you want to submit an issue and you're not sure which tracker it belongs in, just pick the one you think is most appropriate. I'm more interested in getting the feedback then you knowing where to put the issue. I'll move it to the right place if necessary.

## Wikis

PLEASE NOTE: github wikis can be updated by anybody with a github account, and I don't get any notification when wiki pages have changed. Most of the time, users add valuable information, but the structure is poor and always in flux, and there have been occasions in which the information was either misleading or simply inaccurate. The Cucumber features mentioned above, though currently incomplete, are a much better source for accurate documentation.

* [http://wiki.github.com/rspec/rspec/](http://wiki.github.com/rspec/rspec/)
* [http://wiki.github.com/rspec/rspec-core/](http://wiki.github.com/rspec/rspec-core/)
* [http://wiki.github.com/rspec/rspec-expectations/](http://wiki.github.com/rspec/rspec-expectations/)
* [http://wiki.github.com/rspec/rspec-mocks/](http://wiki.github.com/rspec/rspec-mocks/)
* [http://wiki.github.com/rspec/rspec-rails/](http://wiki.github.com/rspec/rspec-rails/)

## The RSpec Book

The RSpec Book is being updated for RSpec-2 and Rails-3. There will still be references back to RSpec-1 and Rails-2 where things have changed, but the focus will be on the way forward. Once the rails-3 and rspec-2 release candidates are out, we'll release one more updated PDF of the book for those in the beta program, and then off to the printer it goes. FINALLY!


