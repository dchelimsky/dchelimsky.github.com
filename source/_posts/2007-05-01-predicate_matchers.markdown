---
author: David
comments: false
date: 2007-05-01 01:00:41+00:00
layout: post
slug: predicate_matchers
title: predicate_matchers
wordpress_id: 26
---

Updated on 5/2/2007






In RSpec-0.8 if you say …





    
    <code>File.should_exist(path)
    </code>





... the expectation passes if File.exist?(path). Here's how that should look in RSpec-0.9, with the underscore removed:





    
    <code>File.should exist(path)
    </code>





Supporting this for any arbitrary predicate would require more method_missing magic than we were willing to stomach, so we added a means of easily declaring methods like this yourself. We've supplied #exist out of the box, but you can add your own with a simple declaration.






Here's how you do this for an individual behaviour:





    
    <code>describe Fish do
    predicate_matchers[:swim] = :can_swim?
    it "should swim" do
      Fish.new.should swim
    end
    end
    </code>





And here's how you define them globally, so they are available in every example in your suite:





    
    <code>Spec::Runner.configure do |config|
    config.predicate_matchers[:swim] = :can_swim?
    end
    </code>
