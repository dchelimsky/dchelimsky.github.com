---
author: David
comments: false
date: 2006-11-15 12:53:38+00:00
layout: post
slug: cohesive-models
title: Cohesive Models
---

Now that Rails uses Ruby to express database structure (migrations), it seems silly to me that we can't just express that right in the model classes. Something like this:

```ruby
class Person < ActiveRecord::Base
  fields do |f|
    f.add :first_name, :string
    f.add :last_name, :string
  end
end
```

Doing this would not only make models more cohesive, but it would make it easier to specify a lot about models without ever touching the database.

We'd need a means of discovering necessary migrations on the fly, and that could get very tricky very quickly, but I think it's worth exploring.
