---
author: David
comments: true
date: 2012-01-05 02:38:03+00:00
layout: post
slug: rspec-28-is-released
title: RSpec-2.8 is released!
wordpress_id: 2856
categories:
- BDD
- RSpec
- Ruby
---

We released RSpec-2.8.0 today with a host of new features and improvements
since 2.7. Some of the highlights are described below, but you can see the
full changelogs at:

* [http://rubydoc.info/gems/rspec-core/file/Changelog.md](http://rubydoc.info/gems/rspec-core/file/Changelog.md)
* [http://rubydoc.info/gems/rspec-expectations/file/Changelog.md](http://rubydoc.info/gems/rspec-expectations/file/Changelog.md)
* [http://rubydoc.info/gems/rspec-mocks/file/Changelog.md](http://rubydoc.info/gems/rspec-mocks/file/Changelog.md)
* [http://rubydoc.info/gems/rspec-rails/file/Changelog.md](http://rubydoc.info/gems/rspec-rails/file/Changelog.md)

## Documentation

While not 100% complete yet, we've made great strides on RSpec's RDoc:

* [http://rubydoc.info/gems/rspec-core](http://rubydoc.info/gems/rspec-core)
* [http://rubydoc.info/gems/rspec-expectations](http://rubydoc.info/gems/rspec-expectations)
* [http://rubydoc.info/gems/rspec-mocks](http://rubydoc.info/gems/rspec-mocks)
* [http://rubydoc.info/gems/rspec-rails](http://rubydoc.info/gems/rspec-rails)

[http://rspec.info](http://rspec.info) is now just a one pager (desperate for
some design love - volunteers please email rspec-users@rubyforge.org). All the
old pages are redirects to the relevant RDoc at http://rubydoc.info. RSpec-1
info is still available at [http://old.rspec.info](http://old.rspec.info).

We've still got Cucumber features up at
[http://relishapp.com/rspec](http://relishapp.com/rspec), but we're going to be
phasing that out as the primary source of documentation. There are a lot of
reasons for this, and I'll try to follow up with a separate blog post on this
topic.

## rspec-core

### Improved support for tags and filtering

You can now set default tags/filters in either `RSpec.configure` or a `.rspec`
file and override these tags on the command line. For example, this configuration
tells rspec to run all the examples that are not tagged `:slow`:


    
    
    # in spec/spec_helper.rb
    RSpec.configure do |c|
      c.treat_symbols_as_metadata_keys_with_true_values = true
      c.filter_run_excluding :slow
    end
    



Now when you want run those, you can just do this:

    rspec --tag slow

This will override the configuration and run onlly the examples tagged `:slow`.

### --order rand

We added an `--order` option with two supported values: `rand` and `default`.

`rspec --order random` (or `rand`) tells RSpec to run the groups in a random
order, and then run the examples within each group in random order. We
implemented it this way (rather than complete randomization of every example)
because we don't want to re-run expensive before(:all) hooks. A fair tradeoff,
as the resulting randomization is just as effective at exposing
order-dependency bugs.

When you use `--order random`, RSpec prints out the random number it used to
seed the randomizer. When you think you've found an order-dependency bug, you
can pass the seed along and the order will remain consistent:

    --order rand:3455

`--order default` tells RSpec to load groups and examples as they are declared
in each file.

### rspec --init

We added an `--init` switch to the `rspec` command to generate a "spec"
directory, and  ".rspec" and "spec/spec_helper.rb" files with some starter code
in them.

## rspec-expectations

We discovered that [the matcher DSL generates matchers that run considerably
slower than classes which implement the matcher
protocol](https://github.com/rspec/rspec-expectations/blob/master/benchmarks/matcher_dsl_vs_classes.rb).
We made some minor improvements in the DSL, but to really improve things we
re-implemented every single built-in matcher as a class.

