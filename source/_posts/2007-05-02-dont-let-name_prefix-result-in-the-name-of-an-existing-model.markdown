---
author: David
comments: false
date: 2007-05-02 00:19:51+00:00
layout: post
slug: dont-let-name_prefix-result-in-the-name-of-an-existing-model
title: don't let :name_prefix result in the name of an existing model
wordpress_id: 29
---

Here's something that bit me today. I'll bet it's documented somewhere, and it makes perfect sense, but maybe I can help you avoid this in case you missed the docs like I did.






### The situation






I'm working on an asset management system which includes Categories and Tags, which have a many-to-many relationship expressed by a CategorizedTag model.





    
    <code>class Category < ActiveRecord::Base
    has_many :tags, :through => :categorized_tags
    has_many :categorized_tags
    end
    
    class Tag < ActiveRecord::Base
    has_many :categories, :through => :categorized_tags
    has_many :categorized_tags
    end
    
    class CategorizedTag < ActiveRecord::Base
    belongs_to :category
    belongs_to :tag
    end
    </code>





### The problem






In routes.rb, I wanted to nest tags inside categories:





    
    <code>  map.resources :categories do |categories|
      categories.resources :tags, :name_prefix => 'categorized_'
    end
    </code>





This seemed fine, but I got a nil-pointer error on categorized_tags_path in a view.






### The fix






Guessing that there was a naming conflict with CategorizedTag, I tried this instead ('category_' instead of 'categorized_'):





    
    <code>  map.resources :categories do |categories|
      categories.resources :tags, :name_prefix => 'category_'
    end
    </code>





Sure enough, category_tags_path worked just fine!






### The moral






So make sure that when you use :name_prefix that it doesn't result in the name of an existing model.
