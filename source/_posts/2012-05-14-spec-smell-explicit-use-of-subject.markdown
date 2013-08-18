---
author: David
comments: true
date: 2012-05-14 02:13:46+00:00
layout: post
slug: spec-smell-explicit-use-of-subject
title: 'Spec smell: explicit use of subject'
wordpress_id: 2918
---


## TL;DR

Explicit use of the "subject" abstraction is a code smell, and should be
refactored to use a more intention revealing name whenever possible.

## One liners

rspec-core supports a one-liner syntax to reduce the noise of common
requirements like validations:

<script src="https://gist.github.com/2691548.js?file=example-1.rb"></script>

Without support for this syntax, the same example might look like this:

<script src="https://gist.github.com/2691548.js?file=example-2.rb"></script>

The benefit of this more verbose example is that it we can read it and
understand all the parts right away: an object is initialized and assigned to a
local variable, then that variable is used for an expectation.

The benefit of the one-liner is that it's terse and expressive, but that comes
at a cost: you can't see what the expectation is being evaluated against, so you
have to understand some underlying mechanics in order to isolate/understand a
failure.

## The `subject` abstraction

Behind the scenes, the one-liner uses a "subject" abstraction supported by two
methods named `subject`. One is a class method on `ExampleGroup`, used to
declare the "subject" of all of the examples in the group:

<script src="https://gist.github.com/2691548.js?file=example-3.rb"></script>

The other is an instance method on `ExampleGroup`. The first time it is called
within an example the block passed to the class' `subject` method is evaluated
and its result memoized, returning the same value from that and each subsequent
`subject` call:

<script src="https://gist.github.com/2691548.js?file=example-4.rb"></script>

Here is what they look like together:

<script src="https://gist.github.com/2691548.js?file=example-5.rb"></script>

The problem with this example is that the word "subject" is not very intention
revealing.  That might not appear problematic in this small example because you
can see the declaration on line 3 and the reference on line 6.  But when this
group grows to where you have to scroll up from the reference to find the
declaration, the generic nature of the word "subject" becomes a hinderance to
understanding and slows you down.

In this case, we'd be better served by using a method (or a `let` declaration)
with an intention revealing name:

<script src="https://gist.github.com/2691548.js?file=example-6.rb"></script>

If we can do that, you might wonder why we have "subject" at all.  Well, it was
originally designed to never be seen:

## Implicit subject

Note in the example with `subject { Article.new }`, that the `subject` declaration is initializing an
`Article` with no args.  Since RSpec knows that the first argument to
`describe` is the `Article` class, it can store a similar block in the
background as a default, implicit subject declaration, leaving us with:

<script src="https://gist.github.com/2691548.js?file=example-7.rb"></script>

That's a little better, but now `subject` appears out of nowhere in the
example, leaving the reader to wonder where it came from.  To remove the need
for explicitly referencing `subject`, the example delegates `should` and
`should_not` to `subject` when it is, itself, the receiver:

<script src="https://gist.github.com/2691548.js?file=example-8.rb"></script>

Starting that line with "should" seems a bit odd though, so the final step is to
do it all in one line:

<script src="https://gist.github.com/2691548.js?file=example-1.rb"></script>

Now we have a completely implicit subject, and the result reads quite nicely in
both the code and the output when run with `--format documentation`: 

    Article
      should validate presence of :title

We still need to trust that something is doing some work for us but it's all
operating at the same level of abstraction, so we don't have to try to
interpret half of the functionality.

## Avoid explicit use of `subject`

Intention revealing names are crucial if you want to be able to quickly scan
and understand code as you navigate around different parts of a system. This is
as true for specs as it is for implementation, and the generic nature of the
word "subject" makes it a poor choice when a more intention revealing name can
be used.

## Is an explicit `subject` ever OK?

Guidelines are guidelines; YMMV. In general I would recommend that if there is
a reasonable way to use an intention revealing name instead of "subject", you
should. The only use case I can think of in RSpec in which another name can't
be used is the one liner syntax:

<script src="https://gist.github.com/2698271.js?file=example-13.rb"></script>

Here we _have_ to use `subject` because that's the only way to tell RSpec where
to send `should` and `should_not`. In my opinion, any other explicit appearance
of `subject` can and should be refactored to use an intention revealing name.

## Update 2012-05-15

Based on feedback on this post, I added support for a "named subject," which
lets you reference the declared subject implicitly in one-liners and with an
intention revealing name in standard examples:

<script src="https://gist.github.com/2698271.js?file=example-14.rb"></script>

This will be released with rspec-core-2.11. Keep your eyes out for it!

