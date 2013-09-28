---
author: David
comments: false
date: 2006-11-27 08:19:19+00:00
layout: post
slug: fighting-the-urge-to-ask
title: Fighting the Urge to Ask
wordpress_id: 5
---

ActiveRecord provides a lot of magic methods that let us get at the properties of a given AR subclass. This is absolutely fantastic news!

Except for one thing.<!-- more -->

Because the resulting getters are public, the entire world of Rails applications (including those that I have written) is infested with violations of encapsulation, TDA (Tell, Don't Ask), Feature Envy and Inappropriate Intimacy. Wow. That's some stinky &^#(.

So what can be done about this? We don't want to encourage the Rails core team to make all the getters private for two reasons. One, there are so many apps in existence already that would break, the entire community would rightfully have my head for even joking about it! Two, it's not THEIR responsibility. It's OURS.

Think of Ruby and the awesome power that we've been granted by open classes. If you want to screw up the coding world you live in by abusing this ability, then have at it. We've done that in RSpec, and are learning the lessons from having done so (don't invade other people's classes so much in a framework!).

The responsibility is ours, as users of the Rails framework, to use it in responsible ways, adhering to the principles of Object Oriented Design that have guided us through the morass of java and .NET applications that have come before.

One example comes from a recent discussion on the RSpec list. The names here have been changed to protect the innocent. Imagine you're writing an app for a Veterinarian's office in which each Pet belongs to a Person. When you're registering a new Pet you want to be able to create the Pet and the Person (pet owner) in one action. So you might have something like this:
    
```ruby
def create
  @person = Person.new(params[:person])
  @pet = Pet.new(params[:pet])
  @person.pets << @pet
  @person.save
end
```

Anybody see the violation of TDA? Anybody smell any Feature Envy? For those who don't, the problem is in this line:
    
```ruby
@person.pets << @pet
```

The problem is that this controller code now depends on the internal structure of the Person - the fact that it keeps a collection of Pets. Now imagine that as this app evolved, we realized that we had the relationship backwards. That, since we are a Pet Health Clinic, after all, everything should revolve around the animal, not the owner. This code (and all the other code in the application like it) will have to change.

We can avoid that change, or any other change to how the Person and Pet relate to each other, by adding an add_pet method to Person:
    
```ruby
@person.add_pet @pet
```

Now, if we decided to reverse the relationship, we could do by having the implementation of add_pet to turn around and add the Person to the Pet:
    
```ruby
class Person < ActiveRecord::Base
  def add_pet pet
    pet.add_person(self)
  end
end
```

Now you could argue that the code that deals w/ People and Pets **should** change to correctly reflect the new model. But by applying Tell, Don't Ask in this case, we can decide when to make that change based on priorities, not based on urgency.

So I urge you to pay attention to these little traps that AR provides for us, and fight the urge to Ask. Just Tell the Other Guy. It'll save your ass some day.
