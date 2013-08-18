---
author: David
comments: false
date: 2008-12-11 11:08:00+00:00
layout: post
slug: a-case-against-a-case-against-mocking-and-stubbing
title: A case against a case against mocking and stubbing
wordpress_id: 1674
categories:
- Isolation Testing
- RSpec
- Test Doubles
---

In his blog entitled [A case against Mocking and Stubbing](http://cardarella.blogspot.com/2008/12/case-against-mocking-and-stubbing.html), Brian Cardarella says
    
>_since I've been TATFT with TDD and some BDD I've come to believe that mocking/stubbing is a horrible idea and it can hurt the development process_

Please take a minute to let that soak in. "a horrible idea" and "can hurt the development process". In fact, please go read the post before you read on. I'd rather you read his words before you read my interpretation of them.

Back? Cool. Scary stuff, huh?

But never fear, because it's not about you (unless you are Brian). What he is really saying is this:

>_since I've been TATFT with my own personal approach to testing Rails applications, which is a little bit different from what the TDD/BDD guys are doing and is largely based on Rails conventions which encourage you to couple layers together in your tests, I've come to believe that mocking and stubbing, two concepts that assist and encourage testing in isolation, which is the opposite of the kind of testing I like to do, is a horrible idea for me and can hurt my own personal development process_

Before I defend my re-phrasing of Brian's statement, let me say that he does have a couple of really good ideas in the post (specifically about the dilemma of databases), and I don't intend to convince you that mocking and stubbing are inherently good ideas that will save the world, or that Brian's process would be improved by adding mocks and stubs to it.

But Brian makes a broad generalization, attacking ideas that many view as inherently useful _in the appropriate context_, and I feel that the scope of his statement requires a bit of narrowing.

<!-- more -->## Rails testing

First, the categories and hierarchy of tests that Brian describes suggest that he is writing Rails applications, and that he's using Rails' categorization of tests, but either replacing rails integration tests with a story/feature tool like cucumber or using such a tool to run in-browser tests, or some combination thereof.

Consider that, although Rails sports an MVC framework, there are really six different layers/compontents we're dealing with: routing, views, controllers, models (model objects), persistence management (model classes), and persistent storage (the database).

Stories as a wrapper for rails integration tests exercise the full stack from the router down to the database and back, so it covers all 6 layers.

Rails functional tests typically start from the controller, down to the database, and back up past the controller to the view, so they incorporate 5 layers.

Rails unit tests start from the model classes and objects and go down to the database as well. Even if you don't save the objects, just loading an ActiveRecord model does cause the model class to ask the database for information about its structure. So unless you're explicitly blocking database access with a tool like NullDB or UnitRecord, these unit tests are really fine grained component integration tests (not to be confused with what rails calls integration tests).

So now we have three categories of tests that are all integration tests that operate on anywhere from 3 to 6 component layers per test. Brian states that "My functional tests should rely upon the models being written properly," but the same is true of the stories. So now we have stories that depend on everything, and functional tests that depend on everything except the router.

## Mocks and Stubs

So let's talk about mocks and stubs for a sec.

Stubs are a form of Test Double that stand in for objects or methods that might require non-trivial setups, access expensive services, or even parts of your system that don't yet exist. They exist to help you isolate the object under test, and assist in both fast running tests and quick fault isolation.

Mocks are generally useful in interaction testing. They help you to think about roles and more general types as opposed to specific objects. They are useful in the short term to help you stay focused on the object you're working on now (mocking its collaborators) and discover new interfaces (again by mocking its collaborators) without having to go over and create those. And they are useful in the long term when you have polymorphic collaborators, so you can specify the interactions once, rather than doing state-based testing n times.

## Integration vs Isolation

Brian's approach to testing is all about integration. Mocking and stubbing is all about isolation. So naturally, these are not a good fit. But that doesn't make mocking or stubbing a bad idea any more than it makes high levels of integration or isolation inherently bad ideas.

## How I approach BDD with Rails

So let me tell you about my own approach to BDD in contrast, and perhaps this will provide some insight into why the rspec-rails gem/plugin is structured the way it is. Here's how I generally like to develop rails apps (I say "like", because this is my general goal, but there are sometimes good reasons to take other approaches):





  1. Write scenarios in plain text with cucumber (driven by user stories, organized in features).


  2. Write the code for a step (or part of a step), run the feature, and observe the failure.


  3. Optionally (yes, it depends - and why is the topic for another blog) drive out a view with a view spec. When I say "drive out," I mean a very granular Red/Green/Refactor cycle that only involves this view, and only enough of this view to support satisfaction of the failing step in the cucumber feature.


  4. Drive out a controller action using the same, granular Red/Green/Refactor cycle. And it may not be the entire controller action I think I want, covering all the cases I think I want. Just enough to support satisfaction of the failing step.


  5. Drive out the parts of the model that I need to satisfy the failing step, using the same granular R/G/R process.


  6. Run the cucumber feature and assess where I am.



At this point Brian talks about going back and writing a new set of Stories. I, by contrast, go back and write the code for the next step.

Brian likes to paint with oil and work in broad strokes with a thick brush. I tend towards fine pencils with tiny strokes that only look like the thing they are part of when you stand back a few feet. Brian likes a lot of integration. I prefer working on small pieces in isolation, with just enough integration to give me confidence that they'll work together correctly when they get wired up at run time.

## Controllers and Views

Controller and view specs are run in isolation from each other so that changes to views will not cause my controller specs to fail, and vice versa. Though either might cause the cucumber scenarios to fail. That's a good thing, and I believe that it is the same thing that Brian is looking for from both his stories and his functional tests.

Controller and view specs are also run in isolation from the models as much as possible. I actually don't usually use tools like UnitRecord or NullDB, but that is because most of the apps I write tend to be pretty small (no more than 10 or 20 models). I think if I was on a bigger team writing bigger apps, I might cave in to the pain of slow test runs and introduce those tools.

But the thing that I try to keep the controller and view specs isolated from is not really the database. It's the validation and other business rules expressed in the model. These are not concerns of the controllers.

## Separation of Concerns

Typically, there are two paths through a controller action: success, or failure. And typically, success or failure is determined by the result of saving or updating the model. Why that save succeeds or fails, the controller doesn't care about. And when model validation rules change, I really don't want to have to go back to my controller specs and start modifying post params to get them to pass.

When model validation rules do change, those changes are first expressed in scenarios. So though application failures won't bubble up from the model specs to the controller and view specs, they **will** bubble up to the cucumber scenarios.

This is clearly a VERY different style from Brian's. Neither is inherently correct or superior. We both operate in our comfort zones. Clearly we both have the same high level goals of delivering quality, maintainable software that meets client need, and being able to do so with a consistent, smooth process that provides a lot of feedback and confidence every step of the way.

## Mocks and stubs are great tools when they are used in the appropriate context

In the end, mocks and stubs are tools. Just like any other tool in our developer toolkits. They each have a narrow purpose. If you're using stubs to isolate the code you're testing, great! If you're using mocks to discover new interfaces on collaborators, great!

If, however, you're trying to stuff these isolation tools into a process that revolves around multiple levels of integration …. please …. stop. In that context, it's really a horrible idea, and might even hurt your development process.
