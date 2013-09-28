---
author: David
comments: false
date: 2007-05-14 15:25:57+00:00
layout: post
slug: an-introduction-to-rspec-part-i
title: an introduction to RSpec - Part I
wordpress_id: 30
categories:
- RSpec
---

Here's an introductory tutorial for those of you interested in getting started with RSpec.

#### Background

Behaviour Driven Development is an Agile development process that comprises aspects of Acceptance Test Driven Planning, Domain Driven Design and Test Driven Development. RSpec is a BDD tool aimed at TDD in the context of BDD.

You could say that RSpec is what is traditionally known as a unit testing framework, but we prefer to describe it as "a Domain Specific Language for describing the expected behaviour of a system with executable examples."

Also, the process that this tutorial guides you through is Test Driven Development at its core, but we use words like "behaviour" and "example" instead of "test case" and "test method".

To understand why we choose this nomenclature, and more detailed history of BDD and RSpec's evolution, check out the writings of "Dan North":http://dannorth.net/tags/agile/bdd/, "Dave Astels":http://daveastels.com/articles/2005/07/05/a-new-look-at-test-driven-development, and "Brian Marick":http://exampler.com/.

Throughout the tutorial, I'll address some of the philosophy behind various choices that are made, but you'll have a much better understanding of them (or at least a context to put them in) if you peruse these recommended readings.

<!-- more -->

#### Prerequisites

* Ruby 1.8.4 or later
* The latest RSpec gem (0.9.4 as of this writing).

To install the RSpec gem, open up a command shell and type …
    
    > gem install rspec

#### Getting Started

For this example, we'll describe and develop the beginnings of a User class, which can be assigned any number of roles. Start by creating a directory for the files for this tutorial:
    
    > mkdir rspec_tutorial
    > cd rspec_tutorial
    
#### The first example

RSpec provides a Domain Specific Language for describing the expected behaviour of a system with executable examples. The first methods we'll encounter are `describe` and `it`. These methods used to have other names (which are still supported but generally not recommended), but we use `describe` and `it` because they lead you to thinking more about behaviour than structure.

Using your favorite editor, create a file in this directory named user_spec.rb and type the following:

```ruby
describe User do
end
```

The `describe` method creates an instance of `Behaviour`. So "describe User" is really saying "describe the behaviour of the User class". I guess we could have named the method `describe_the_behaviour_of`, but there is a point at which clarity bumps up against verbosity, and we feel that point is before the first underscore in ` describe_the_behaviour_of`.

In the shell, type the following command:
    
    > spec user_spec.rb

The `spec` command gets installed when you install the rspec gem. It supports a large number of command line options. Most of the options are outside the scope of this tutorial, but you can learn about them by running the command without any arguments:

    > spec

Getting back to the task at hand, running `spec user_spec.rb` should have resulted in output that includes the following error:
    
    ./user_spec.rb:1: uninitialized constant User (NameError)

We haven't even written any examples and already RSpec is telling us what code we need to write. We need to create a User class to resolve this error, so create user.rb with the following:
    
```ruby
class User
end
```

... and require it in user\_spec.rb:

```ruby
require 'user'

describe User do
end
```

Now run the `spec` command again.
    
    $ spec user_spec.rb
    
    Finished in 6.0e-06 seconds
    
    0 examples, 0 failures
    
The output shows that we have no examples yet, so lets add one. We'll start by describing the intent of example without any code.

```ruby
describe User do
  it "should be in any roles assigned to it" do
  end
end
```

The `it` method returns an instance of `Example`. This is a metaphor for an example of the behaviour that we are describing.

Read that out loud. It is quite satisfying. We can thank [Dan North](http://dannorth.net) for the names `describe` and `it`.

Run the `spec`, but this time add the `--format` option:

    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    
    Finished in 0.022865 seconds
    
    1 example, 0 failures

The `specdoc` format outputs the name of each Behaviour (the object created by the `describe` method) and each Example (the object created by the `it` method). This format comes from [TestDox](http://agiledox.sourceforge.net/), a tool which produces a similar report from the names of JUnit TestCases and methods within.

Now add a Ruby statement that begins to express the described intent.

```ruby
describe User do
  it "should be in any roles assigned to it" do
    user.should be_in_role("assigned role")
  end
end
```

... and run the `spec` command.

    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it (ERROR - 1)
    
    1)
    NameError in 'User should be in any roles assigned to it'
    undefined local variable or method `user' for #<#<Class:0x14ed15c>:0x14ecdd8>
    ./user_spec.rb:6:
    
    Finished in 0.017956 seconds
    
    1 example, 1 failure

There are a couple of things to note about this output. First, the text "(ERROR - 1)" tells us that there was an error in the "should be in any roles assigned to it" example. The "1" tells us that as we scroll down to the detailed failure report that this particular failure is described under "1)". This will become more useful as the number of examples increases.

Another thing to note is the absence of any references to RSpec code in the backtrace. RSpec filters that out by default, however you can see the entire backtrace by adding the `--backtrace` switch to the command.

The output tells us that there is no `user`, so the next step is to make one:

```ruby
describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.should be_in_role("assigned role")
  end
end
```
    
    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it (ERROR - 1)
    
    1)
    NoMethodError in 'User should be in any roles assigned to it'
    undefined method `in_role?' for #<User:0x14ec8ec>
    ./user_spec.rb:7:
    
    Finished in 0.020779 seconds
    
    1 example, 1 failure

Now we learn that User does not respond to `in_role?`, so we add that to User:

```ruby
class User
  def in_role?(role)
  end
end
```

    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it (FAILED - 1)
    
    1)
    'User should be in any roles assigned to it' FAILED
    expected in_role?("assigned role") to return true, got nil
    ./user_spec.rb:7:
    
    Finished in 0.0172110000000001 seconds
    
    1 example, 1 failure

We now have a failing example, which is the first goal. We always want to see a meaningful failure before success because that's the only way we can be sure the success is the result of writing code in the right place in the system.

To get this to pass, we do the simplest thing that could possibly work:
    
```ruby
class User
  def in_role?(role)
    true
  end
end
```
    
    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    
    Finished in 0.018173 seconds
    
    1 example, 0 failures
    
That passes, but we're not done yet. Take a look again at the example:

```ruby
describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.should be_in_role("assigned role")
  end
end
```

Does that express the described intent? Not fully. The description says that the User "should be in any roles assigned to it", but we haven't assigned any roles to it. Let's add that assignment to the example:

```ruby
describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end
end
```
    
    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it (ERROR - 1)
    
    1)
    NoMethodError in 'User should be in any roles assigned to it'
    undefined method `assign_role' for #<User:0x14ec784>
    ./user_spec.rb:6:
    
    Finished in 0.018564 seconds
    
    1 example, 1 failure

Following the advice in the output, we now add the `assign_role` method to `User`.


```ruby
class User
  def in_role?(role)
    true
  end
  
  def assign_role(role)
  end
end
```
    
    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    
    Finished in 0.018998 seconds
    
    1 example, 0 failures

The example is passing again, but are we done yet? Scroll up a few lines and take a look at the current implementation of `User`. I think it's fair to say that this is NOT the implementation that we know we want to end up with. And this is the point in the process that makes TDD "Test-Driven". Rather than implementing the code we **think** that we **know** that we want, we're going to proceed under the guidance of the principle that "code does not exist until it is tested."

Right now, the only requirement of this system that we've expressed is that a "User should be in any roles assigned to it", and the system meets that requirement. In order to push the code to the next step, we need to express more requirements with more executable examples.

#### The second example

As things stand now, a `User` will answer `true` when you ask it if it is any role, regardless of whether it has been assigned that role. We want the `User` to tell is it is not in a role which it has not been assigned, so let's add that example:

```ruby
describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end
  
  it "should NOT be in any roles not assigned to it" do
  end
end
```
    
    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    - should NOT be in any roles not assigned to it
    
    Finished in 0.018231 seconds
    
    2 examples, 0 failures

Now add a statement to express intent:

```ruby
describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end
  
  it "should NOT be in any roles not assigned to it" do
    user.should_not be_in_role("unassigned role")
  end
end
```

    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    - should NOT be in any roles not assigned to it (ERROR - 1)
    
    1)
    NameError in 'User should NOT be in any roles not assigned to it'
    undefined local variable or method `user' for #<#<Class:0x14eca54>:0x14ebce4>
    ./user_spec.rb:11:
    
    Finished in 0.018465 seconds
    
    2 examples, 1 failure

Now create the `User`:

```ruby
describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end
  
  it "should NOT be in any roles not assigned to it" do
    user = User.new
    user.should_not be_in_role("unassigned role")
  end
end
```
    
    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    - should NOT be in any roles not assigned to it (FAILED - 1)
    
    1)
    'User should NOT be in any roles not assigned to it' FAILED
    expected in_role?("unassigned role") to return false, got true
    ./user_spec.rb:12:
    
    Finished in 0.019014 seconds
    
    2 examples, 1 failure

Once again we have an example that is failing in the way we want it to fail - the intent is correctly expressed, but the code is not behaving as expected.

Doing the simplest thing that could possibly work, we can get the example to pass like so:

```ruby
class User
  def in_role?(role)
    role == "assigned role"
  end
  
  def assign_role(role)
  end
end
```
    
    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    - should NOT be in any roles not assigned to it
    
    Finished in 0.017194 seconds
    
    2 examples, 0 failures

Everything passes, but now we have duplication between the examples and the subject code. Time to refactor to remove the duplication!

```ruby
class User
  def in_role?(role)
    role == @role
  end
  
  def assign_role(role)
    @role = role
  end
end
```

    $ spec user_spec.rb --format specdoc
    
    User
    - should be in any roles assigned to it
    - should NOT be in any roles not assigned to it
    
    Finished in 0.018199 seconds
    
    2 examples, 0 failures

At this point, you probably feel as though the implementation is not quite right yet. That feeling is based on an assumption that we should be able to assign any number of roles to a `User`. Part of that assumption comes from our initial example: "should be in any roles assigned to it". Before diving in and changing the implementation, this is a great time to ask the customer whether that assumption is correct! If the answer is that a `User` can only be in one role at a time, then we're done with the code but we should probably re-phrase the examples to read "should be in the role assigned to it" and "should NOT be in a role not assigned to it".

If the answer is that a `User` can be in more than one role at a time, then we have more work to do. I'll address this scenario in Part II of this tutorial. Stay tuned …
