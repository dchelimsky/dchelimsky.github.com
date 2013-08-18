---
author: David
comments: false
date: 2007-06-28 06:57:15+00:00
layout: post
slug: template-expects_render
title: template.expects_render
wordpress_id: 39
---

One thing that's been missing from rspec_on_rails for a while is a clean and consistent way to mock or stub calls to partials from inside partials. In fact, even mocking partials inside non-partial templates has been buggy. For example, let's say you're describing a template that should include a partial named '_thing'. You might want to do something like this:





    
    <code>assigns[:thing] = thing = Object.new
    template.should_receive(:render).with(
    :partial => 'thing',
    :object => thing
    )
    render 'things/index.html.erb'
    </code>





Now if that is the only example in your entire suite that renders 'things/index.html.erb', no problem. In other words, in most cases, this is a problem.






#### The Problem






It turns out that Rails compiles ERB templates in memory the first time they are encountered and continues to use the compiled version throughout a given process. This is a GOOD thing for performance. It is, however, a challenge for testability. Why? Because when we stub methods using rspec, mocha or flexmock, we replace the real methods with implementations from the mocking framework. Those methods are part of what gets compiled. And that means WEIRD STUFF.






If you mock a method in the template and the template gets compiled, then every other access to that template accesses the mocked method (even accesses in other examples). Conversely, if you mock a method in a template that's already been compiled, well, it just doesn't get hooked up at all and the mock expectation fails.






The problem with mocking partials inside partials is that a response only has one instance of ActionView::Base, so if you mock one call to render on that instance, you mock them all. This means that you simply can not use a standard mocking framework to mock the call as they are simply not designed to pass some calls on to the real object and intercept others.






#### RSpec's Solution






To solve this, I created a proxy that delegates to a mock object, but that mock behaviour is not added to ActionView::Base directly. When ActionView::Base receives #render, it asks the proxy if it is interested in the call based on the arguments that were passed in. If so, it passes it on to the mock proxy for later verification, and otherwise swallows the call, the way a mock normally would. If it is not, however, interested in the call, execution of the render method continues as normal.






I have to confess that this feels a bit dirty. I come from a land of fairly strict rules about what mocks should and should not do, but now live in a land in which a lot of rules I learned before are being challenged. This is the land of Ruby and Rails. And so I grit my teeth, and do what seems pragmatic.






#### View Examples






The result is that you'll now be able to do this in View Examples:





    
    <code>assigns[:thing] = thing = Object.new
    template.expects_render(:partial => 'thing', :object => thing)
    render 'things/index.html.erb'
    </code>





You can even do this if the thing you're rendering in the example IS a partial which contains a sub-partial:





    
    <code>thing = Object.new
    template.expects_render(:partial => 'thing', :object => thing)
    render :partial => 'outer_partial', :locals => {:thing => thing}
    </code>





#### Controller Examples too






I also added the same behaviour to controllers in Controller Examples. This essentially restores the old `controller.should_render` behaviour that we gave up in RSpec 0.9, but with the syntax similar to that in the view examples above:





    
    <code>controller.expects_render(:action => 'login')
    get 'index'
    </code>





Thanks to [Jake Scruggs](http://jakescruggs.blogspot.com/) for pairing on this with me. It might not have happened had he not offered to help.






#### When can I use it?






This is committed to RSpec's trunk and will be released with RSpec-1.0.6, sometime very soon.
