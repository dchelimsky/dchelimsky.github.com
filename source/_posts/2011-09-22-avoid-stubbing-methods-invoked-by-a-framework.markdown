---
author: David
comments: true
date: 2011-09-22 23:23:55+00:00
layout: post
slug: avoid-stubbing-methods-invoked-by-a-framework
title: Avoid stubbing methods invoked by a framework
wordpress_id: 2826
categories:
- BDD
- RSpec
- Rails
- Ruby
- Test Doubles
---

In a [github issue](https://github.com/rspec/rspec-mocks/issues/78) reported to
the [rspec-mocks](https://github.com/rspec/rspec-mocks) project, the user had
run into a problem in a Rails' controller spec in which an RSpec-generated test
double didn't behave as expected. What follows is an edited version of the
issue and my response, with the hope that it reaches a wider audience and/or
sparks some conversation.

## The reported problem: ActiveSupport::JSON::Encoding::CircularReferenceError using doubles

This spec ...


    
    
    require 'spec_helper'
    
    describe ListsController do
      let(:list) { double("List") }
    
      describe "GET 'index'" do
        let(:expected) { [{id: "1", name: "test"}] }
    
        before do
          list.stub(:id){ "1" }
          list.stub(:name){ "test" }
          List.stub(:select){ [ list ] }
        end
    
        it "should return the list of lists" do
          get :index, format: :json
          response.body.should == expected.to_json
        end
      end
    end
    



... plus this implementation ...


    
    
    class ListsController < ApplicationController
      respond_to :json
    
      expose(:lists) { List.select("id, name") }
    
      def index
        respond_with(lists)
      end
    end
    



... produces this failure:


    
    
      Failure/Error: get :index, format: :json
         ActiveSupport::JSON::Encoding::CircularReferenceError:
           object references itself
    



## The deeper problem: this is a great example of when _not_ to use stubs.

Here's why: there are three incorrect assumptions hiding behind the stubs!

1. `select` takes an Array: `List.select(["id","name"])`, but the example stubs it incorrectly.
2. the id is numeric, but the example uses String.
3. the json is wrapped: `{"list":{"id":1,"name":"test"}}`, but the example doesn't wrap it.

Even if the stubs were properly aligned with reality, the reason for the error
is that `respond_with(lists)` eventually calls `as_json` on the `list` object,
which, in this example, is an RSpec double that doesn't implement `as_json`.
We need to either use a `stub_model` (which does implement `as_json`), or
explicitly stub it in the example:


    
    
    list.stub(:as_json) { { list: {id: 1, name: "test"} } }
    



But I'd avoid stubs altogether in this case. Stubs are great for well defined
(and understood) public APIs _which are invoked by the code being specified_.
In this case, we're stubbing an API (`as_json`) that is invoked by the Rails
framework, not the code being specified. If the Rails framework ever changes
how it renders json, this example would continue to pass, but it would be a
false positive.

## One possible remedy

#### Here's how I'd approach this outside-in (based on my own flow, design preferences, and target outcomes. YMMV.)

Start with a request spec:


    
    
    require 'spec_helper'
    
    describe "Lists" do
      describe "GET 'index.json'" do
        it "returns the list of lists" do
          list = List.create!(name: "test")
          get "/lists.json"
          response.body.should == [{list: {id: list.id, name: "test"}}].to_json
        end
      end
    end
    



This shows exactly what to expect, so when working on clients we can refer
directly to this without having to dig into internals.

Run this and it fails with `uninitialized constant List`, so generate the list
resource:


    
    
    rails generate resource list name:string
    rake db:migrate
    rake db:test:prepare
    



Run it again and it fails with `ActionView::MissingTemplate`. Now we have a
couple of choices. The purist view says "write a controller spec", but some
people say controller specs are unnecessary if there are already request specs
(or cukes) as they just add duplication. 

For me, the answer depends upon the complexity of the requirement as it
compares to what we get for free from Rails. In this case, the only difference
between the requirement and what Rails gives us for free is that we constrain
the fields to `id` and `name` This is something we can implement in the model,
so I'd just implement this very simple controller code and move on:


    
    
    class ListsController < ApplicationController
      respond_to :json
    
      def index
        respond_with List.all
      end
    end
    



Now the request spec fails with:


    
    
    expected: "[{\"list\":{\"id\":1,\"name\":\"test\"}}]"
         got: "[{\"list\":{\"created_at\":\"2011-08-27T14:56:19Z\",\"id\":1,\"name\":\"test\",\"updated_at\":\"2011-08-27T14:56:19Z\"}}]"
    



We're getting more key/value pairs than we want. I want the model responsible
for constraining the keys in the json (Rails implements json transformations in
the context of the model, so why shouldn't we?), so I'd add a model spec:


    
    
    require 'spec_helper'
    
    describe List do
      describe "#as_json" do
        it "constrains keys to id and name" do
          list = List.new(:name => "things")
          list.as_json['list'].keys.should eq(%w[id name])
        end
      end
    end
    



This fails with:


    
    
    expected ["id", "name"]
         got ["created_at", "name", "updated_at"]
    



I expect to see `created_at` and `updated_at`, but I'm surprised (initially) to
see that `id` is missing. Thinking this through, it makes sense because the
example generates the `list` using `new`, so no `id` is generated.  To get `id`
to show up in the list of keys, we can use `create` instead of `new`, or we can
explicitly set it. I'm going to go with setting the id explicitly to avoid the
db hit, accepting the self-imposed leaky abstraction. It's all trade-offs.  


    
    
    it "constrains fields to id and name" do
      list = List.new(:name => "things")
      list.id = 37
      list.as_json['list'].keys.should eq(%w[id name])
    end
    



Now it fails with:


    
    
    expected ["id", "name"]
         got ["created_at", "id", "name", "updated_at"]
    



Now we can implement the constraint:


    
    
    class List < ActiveRecord::Base
      def as_json
        super({ only: %w[id name]})
      end
    end
    



Now the model spec passes, but the request spec fails with:


    
    
    ArgumentError:
      wrong number of arguments (1 for 0)
    



This is because the `as_json` implementation fails to honor the [Rails
API](http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json):


    
    
    as_json(options = nil)
    



`as_json` is called by the Rails framework with an options hash. Had we done
this without the request spec and weren't aware of this information, we'd have
a bunch of passing specs but the app would blow up. Hooray for testing at
multiple levels!

So we add a new example to the model spec:


    
    
    it "honors the submitted options hash" do
      list = List.new(:name => "things")
      list.id = 37
      list.as_json(:only => :name)['list'].keys.should eq(%w[name])
    end
    



This fails with `wrong number of arguments (1 for 0)` as well, so now we adjust
the model implementation:


    
    
    def as_json(opts={})
      super({ only: %w[id name]}.merge(opts))
    end
    



Now the model spec passes again, and so does the request spec! DONE!

The result is a very nice balance of clarity, speed (in spite of the one db hit
in the request spec) and flexibility. Any new endpoints we add will get the
same json representation because it is expressed in the model (heeding the
principle of least surprise). The model spec not only specifies how the model
should represent itself as json, but it helps to explain how the rails
framework uses the model. All of this with no stubbing at all, and especially
no stubbing of APIs our code isn't invoking.

