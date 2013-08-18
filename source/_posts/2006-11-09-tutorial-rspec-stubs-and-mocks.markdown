---
author: David
comments: false
date: 2006-11-09 23:56:41+00:00
layout: post
slug: tutorial-rspec-stubs-and-mocks
title: 'tutorial - rspec: stubs and mocks'
wordpress_id: 3
categories:
- BDD
- RSpec
---

RSpec’s mocking/stubbing facilities are enhanced significantly in RSpec-0.7.

You can now intermingle stub methods and mock expectations on the same objects. This applies to instances of Spec::Mocks::Mock or ANY other object or class.

Having integrated stubs and mocks available not only supports isolated and fast controller specs, it also provides a nice way to separate setup noise from the “interesting bits” in your specs. I try to exploit this by preferring stub methods (stub!) in my setup and mock expectations (should_receive) in specify blocks.










    
    1<tt>
    </tt>2<tt>
    </tt>3<tt>
    </tt>4<tt>
    </tt><strong>5</strong><tt>
    </tt>6<tt>
    </tt>7<tt>
    </tt>8<tt>
    </tt>9<tt>
    </tt><strong>10</strong><tt>
    </tt>11<tt>
    </tt>12<tt>
    </tt>13<tt>
    </tt>14<tt>
    </tt><strong>15</strong><tt>
    </tt>16<tt>
    </tt>17<tt>
    </tt>18<tt>
    </tt>19<tt>
    </tt><strong>20</strong><tt>
    </tt>21<tt>
    </tt>22<tt>
    </tt>23<tt>
    </tt>24<tt>
    </tt><strong>25</strong><tt>
    </tt>







    
    <tt>
    </tt>context <span class="s"><span class="dl">"</span><span class="k">the PersonController</span><span class="dl">"</span></span> <span class="r">do</span><tt>
    </tt>  controller_name <span class="sy">:person</span><tt>
    </tt>  <tt>
    </tt>  setup <span class="r">do</span><tt>
    </tt>    <span class="iv">@person</span> = mock(<span class="s"><span class="dl">"</span><span class="k">person</span><span class="dl">"</span></span>)<tt>
    </tt>    <span class="co">Person</span>.stub!(<span class="sy">:new</span>).and_return(<span class="iv">@person</span>)<tt>
    </tt>  <span class="r">end</span><tt>
    </tt>  <tt>
    </tt>  specify <span class="s"><span class="dl">"</span><span class="k">should create a new person on GET to create</span><span class="dl">"</span></span> <span class="r">do</span><tt>
    </tt>    <span class="co">Person</span>.should_receive(<span class="sy">:new</span>).and_return(<span class="iv">@person</span>)<tt>
    </tt>    get <span class="s"><span class="dl">'</span><span class="k">create</span><span class="dl">'</span></span><tt>
    </tt>  <span class="r">end</span><tt>
    </tt>  <tt>
    </tt>  specify <span class="s"><span class="dl">"</span><span class="k">should assign new person to template on GET to create</span><span class="dl">"</span></span> <span class="r">do</span><tt>
    </tt>    get <span class="s"><span class="dl">'</span><span class="k">create</span><span class="dl">'</span></span><tt>
    </tt>    assigns[<span class="sy">:person</span>].should_be <span class="iv">@person</span><tt>
    </tt>  <span class="r">end</span><tt>
    </tt>  <tt>
    </tt>  specify <span class="s"><span class="dl">"</span><span class="k">should render 'person/create' on GET to create</span><span class="dl">"</span></span> <span class="r">do</span><tt>
    </tt>    controller.should_render <span class="sy">:template</span> => <span class="s"><span class="dl">"</span><span class="k">person/create</span><span class="dl">"</span></span><tt>
    </tt>    get <span class="s"><span class="dl">'</span><span class="k">create</span><span class="dl">'</span></span><tt>
    </tt>  <span class="r">end</span><tt>
    </tt>  <tt>
    </tt><span class="r">end</span><tt>
    </tt>






In this example, the line …

    
    <code>
    Person.stub!(:new).and_return(@person)
    </code>


... in setup stubs the method so GET ‘create’ will work every time. The line …

    
    <code>
    Person.should_receive(:new).and_return(@person)
    </code>


... in the specify block “should create a new person on GET to create” sets an expectation that must be met. Even though it seems like duplication of the stub method, it is serving a different function: it tells the story for that spec.

Note how in the other specs there is no focus on Person.new. It’s out of the way, but the stub in the setup makes sure its taken care of.

So use stubs to take care of the “noise” (in this case stuff that has to be there to get the specs to run), and use mock expectations to put focus on the fact that something is expected.
