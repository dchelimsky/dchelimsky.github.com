---
author: David
comments: true
date: 2010-12-23 05:57:33+00:00
layout: post
slug: rspec-2-documentation-2
title: RSpec 2 Documentation
wordpress_id: 2732
---

[RSpec-2](http://relishapp.com/rspec) was released with, admittedly, [less](http://twitter.com/geoffreywiseman/status/17213578851389441) [than](http://twitter.com/mattbaker/statuses/15929510696321025) [complete](http://twitter.com/bhuga/statuses/16050194697166848) documentation. The [new docs](http://relishapp.com/rspec) are a work in progress that need your help. It's all open source, and anybody who can write [Markdown](http://daringfireball.net/projects/markdown/) or [Cucumber](http://cukes.info) can contribute to it. Here's how:

## You

Fork the git repo you of the rspec project to which you want to contribute docs, make additions/edits to appropriate files in the `features` directory, and submit pull requests.

## Me

I review, tweak, and organize the contributions, merge them in, and then push them to [http://relishapp.com](http://relishapp.com).

## Source repositories

With the exception of the [front page](http://relishapp.com/rspec), all of the docs are stored in the `features` directories of rspec repositories on [github](http://github.com):

[rspec-core](https://github.com/rspec/rspec-core/tree/master/features)  

[rspec-expectations](https://github.com/rspec/rspec-expectations/tree/master/features)  

[rspec-mocks](https://github.com/rspec/rspec-mocks/tree/master/features)  

[rspec-rails](https://github.com/rspec/rspec-rails/tree/master/features)

## [Relish](http://relishapp.com)

Relish is an application developed by [Justin Ko](http://justinko.me) and [Matt Wynne](http://blog.mattwynne.net/) to display Cucumber features for open and closed source projects. It is still fairly new and under regular development, so presentation, navigation, etc, are all improving as we go.

Cucumber and Markdown docs live in the `features` directory (and its subdirectories) in each project. There is a `.nav` file that sorts the navigation links. It's pretty self-explanatory, and you probably won't need to touch it. But now you know what it is.

## Cukes

If you know what you're doing with Cucumber, feel free to submit executable scenarios. Please make sure you run them and they pass against ruby-1.8.6, 1.8.7, 1.9.1, and 1.9.2. Bonus points for jruby and rbx.

Even if you don't know what you're doing with Cucumber, all of the Cucumber features have a narrative section at the top, which is plain text and not executed. Relish processes this section through Markdown, so it can be as expressive as you know how to make Markdown "speak." Patches that add to this narrative are great, but so are patches that simply re-format them to make them more readable.

## Pages

In addition to the Cucumber features, Relish supports pages using Markdown. Each project has a README file in the `features` directory which is displayed as the [front page for that project](http://relishapp.com/rspec/rspec-core). Each subdirectory below `features` can also have a README (optional), which would be displayed as the [front page of that directory](http://relishapp.com/rspec/rspec-rails/v/2-3/dir/controller-specs).

In addition to the README files, we can add [arbitrary pages using Markdown as well](http://relishapp.com/rspec/rspec-core/v/2-3/file/upgrade](http://relishapp.com/rspec/rspec-core/v/2-3/file/upgrade).

## Questions?

If you want to help and you're not sure where to start, feel free to contact me via email to the [rspec-users list](http://rubyforge.org/mailman/listinfo/rspec-users) or a github issue in the project you're interested in contributing to.

### Thanks in advance for your help!
