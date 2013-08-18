---
author: David
comments: true
date: 2012-02-12 22:53:27+00:00
layout: post
slug: validations-are-behavior-associations-are-structure
title: Validations are behavior, associations are structure
wordpress_id: 2869
categories:
- RSpec
- Ruby
---

## TL;DR:

* TDD is about specifying behavior, not structure.
* Validations are behavior, and should be specified.
* Associations are structure, and need not be.

## Disclaimer

This is my personal viewpoint, though it is not mine alone. YMMV.

## Declarations

ActiveRecord provides a declarative interface for describing the structure and
behavior of a model:

<script src="https://gist.github.com/2359140.js?file=article.rb"></script>

While syntactically similar, these two declarations do fundamentally different
things.

## Validations are behavior

The `validates_presence_of :title` declaration changes the behavior of
the `save` method (and other methods that use `save`), and should be specified
explicitly. Here's an example using shoulda matchers:

<script src="https://gist.github.com/2359140.js?file=validate_presence_of_title.rb"></script>

Even though the matcher's name looks just like the likely implementation, the
`validate_presence_of` matcher specifies that you can not save an `Article`
without a non-nil value for `title`, not that the
`validates_presence_of(:title)` declaration exists.

## Associations are structure

The `has_many` declaration exposes a `comments` method to clients that appears
to be a collection of `Comment` objects. Doing Test-Driven Development, you
would add this declaration when a specified behavior requires it e.g.

<script src="https://gist.github.com/2359140.js?file=with_comments_by.rb"></script>

This example needs a `comments` method that returns a collection in order to
pass.  If it doesn't exist already (because no other example drove you to add
it), this would be all the motivation you need to introduce it. You don't need
an example that says `it "should have_many(:comments)"`.

## Testing the framework

Some will argue that we don't need to spec validations either, suggesting that
`it "should validate_presence_of(:title)"` is testing the Rails framework,
which we trust is already tested.  If you think of TDD as a combination of
specification, documentation, and regression testing, then this argument falls
short on the specification/documentation front because the validation is
behavior and, thus, the spec should specify the validation.

Even if you view testing as nothing more than a safety net against regressions,
the argument still falls down in the face of refactoring. If we add a `Review`
class that also `has_many(:comments)` and `validates_presence_of(:title)`, and
we want to extract that behavior to a `Postable` module that gets included in
both `Article` and `Review`, we'd want a regression test to fail if we failed
to include either of those declarations in the `Postable` module.

## But declarations are already declarative!

Another argument is that declarations supply sufficient documentation. e.g. we
can look at `rental_contract.rb` and know that it validates the presence of
`:rentable`:

<script src="https://gist.github.com/2359140.js?file=rental_contract.rb"></script>

This is an interesting argument that I think has some merit, but I think it
would require an extraordinarily disciplined and consistent approach of using
declarations 100% of the time in model files such that each one _is the spec_
for that model, e.g.

<script src="https://gist.github.com/2359140.js?file=contract.rb"></script>

100% may sound extreme, but as soon as we define a single method body in any
one of the models, the declarative nature of the file begins to degrade, and so
does its fitness for the purpose of specification. Plus, if we can only
understand the expected behavior of a model by looking at _both_ its spec and
its implementation, we've lost some of the power of a test-driven approach.

## What do you think?

Do you spec associations? If so, what value do you get from doing so? If not,
have you run into situations where you wished you had?

Same questions for validations.
