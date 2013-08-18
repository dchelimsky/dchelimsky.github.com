---
author: David
comments: true
date: 2010-06-14 13:08:20+00:00
layout: post
slug: filtering-examples-in-rspec-2
title: Filtering examples in rspec-2
wordpress_id: 2625
categories:
- RSpec
tag:
- rspec-2
---

In [RSpec-2](), every example group and example has associated metadata, to which you can append arbitrary information. This allows you to slice and dice a spec suite in a variety of ways.

### Adding arbitrary metadata

The `describe` and `it` methods, and their aliases, each accept a hash as the last argument before the block:


    
    
    describe "something", :this => {:is => :arbitrary} do
    it "does something", :and => "so is this" do
      # ...
    end
    end
    



### `filter_run`

The keys in these hashes can be accessed in a number of ways via `RSpec.configure`. If, for example, you're working on a specific example and don't want to run the full suite, you can use the `filter_run` method on the configuration like this:


    
    
    # in spec/spec_helper.rb
    RSpec.configure do |c|
    c.filter_run :focus => true
    end
    
    # in spec/any_spec.rb
    describe "something" do
    it "does something", :focus => true do
      # ....
    end
    end
    



Now if you run `rspec spec`, it will only run that one example, no matter how many others there are in the suite.

This works for examples and groups, so if you want to run all the examples in one group that you're focusing on, but nothing else, you can do this:


    
    
    RSpec.configure do |c|
    c.filter_run :focus => true
    end
    
    describe "something", :focus => true do
    it "does something" do
      # ....
    end
    it "does something else" do
      # ....
    end
    end
    



The `rspec` command would now run both of the examples in that group.

### `filter_run_excluding`

This is the inverse of `filter_run`. It excludes any examples or groups that match the filter:


    
    
    RSpec.configure do |c|
    c.filter_run_excluding :slow => true
    end
    
    describe "something", :slow => true do
    it "does something" do
      # ....
    end
    it "does something else" do
      # ....
    end
    end
    



The `rspec` command would now run all the other examples in the suite, but not these two.

NOTE: `filter_run_excluding` was added in beta.12, which was just released this morning.

### `lambda`

You can filter on runtime conditions by assigning a lambda to a key. If your app is expected to behave differently in different versions of Ruby, you can use a `lambda` with `filter_run_excluding` like this:


    
    
    RSpec.configure do |c|
    c.filter_run_excluding :ruby => lambda {|version|
      !(RUBY_VERSION.to_s =~ /^#{version.to_s}/)
    }
    end
    
    describe "something" do
    it "does something", :ruby => 1.8 do
      # ....
    end
    it "does something", :ruby => 1.9 do
      # ....
    end
    end
    



This example comes directly from rspec-core's own `spec_helper.rb`.

RSpec passes 1.8 and 1.9 to the lambda, which accepts it as the `version` block argument. If the lambda returns `true`, the example is _excluded_ from the run (because we're using `filter_run_excluding`). Now the first example will only run if the ruby version is 1.8. Similarly, the latter example only runs under 1.9.


### (no) command line support (yet)

We plan to add some sort of command line API to access these filters, but we're not sure yet what this is going to look like. There is an [open issue in github issues for rspec-core](http://github.com/rspec/rspec-core/issues/37) . Please feel free to review and add any comments there.
