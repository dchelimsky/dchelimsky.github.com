---
author: David
comments: false
date: 2006-11-06 16:11:15+00:00
layout: post
slug: view-spec-tutorial
title: tutorial - driving view behaviour with 'spec/rails'
wordpress_id: 1
---

[Updated for 0.9 on 2007/04/12]

rspec-0.9's 'spec/rails' (RSpec on Rails) plugin lets you spec your views in complete isolation of any controllers. This means that you can spec your views even before there are any models or controllers! Once models and controllers do exist, changes to them will not cause your view specs to fail.

Here's a brief tutorial to get you started.
<!-- more -->

Create a new rails app.



  rails oldnews



Now install rspec and rspec_on_rails plugins.



  cd oldnews
  ruby script/plugin install svn://rubyforge.org/var/svn/rspec/tags/REL_0_9_0_BETA_2/rspec
  ruby script/plugin install svn://rubyforge.org/var/svn/rspec/tags/REL_0_9_0_BETA_2/rspec_on_rails
  ruby script/generate rspec



Next, using the rspec controller generator, create a controller for articles:



  $ script/generate rspec_controller  articles list show
        exists  app/controllers/
        exists  app/helpers/
        create  app/views/articles
        create  spec/controllers/
        create  spec/helpers/
        create  spec/views/articles
        create  spec/controllers/articles_controller_spec.rb
        create  spec/helpers/articles_helper_spec.rb
        create  app/controllers/articles_controller.rb
        create  app/helpers/articles_helper.rb
        create  spec/views/articles/list_view_spec.rb
        create  app/views/articles/list.rhtml
        create  spec/views/articles/show_view_spec.rb
        create  app/views/articles/show.rhtml



Open up spec/views/articles/list_view_spec.rb and update it as follows:




    
    
    require File.dirname(__FILE__) + '/../../spec_helper'
    
    describe "articles/list with just one article" do
    it "should display the title" do
      render 'articles/list'
      response.should have_tag('div', "example title")
    end
    end
    





Now run the specs - stand in the project root and …



  ruby spec/views/articles/list_view_spec.rb -fs
  


... and you should get output like this (plus some backtrace info) ...



  articles/list with just one article
  - should display the title (FAILED - 1)

  1)
  'articles/list with just one article should display the title' FAILED
  Expected at least 1 elements, found 0.
   is not true.



Open up app/views/articles/list.rhtml and edit as follows…



  

example title





Run the spec again and you'll see that it passes. We have duplication between the spec and the subject code. To get rid of it, we'll have to feed the view some data that it can display. Add a setup to the spec:




    
    
    require File.dirname(__FILE__) + '/../../spec_helper'
    
    describe "articles/list with just one article" do
    before do
      @article = mock("article")
      @article.should_receive(:title).and_return("example title")
      assigns[:articles] = [@article]
    end
    it "should display the title" do
      render 'articles/list'
      response.should have_tag('div', "example title")
    end
    end
    





... and run the specs …



  articles/list with just one article
  - should display the title (ERROR - 1)

  1)
  Spec::Mocks::MockExpectationError in 'articles/list with just one article should display the title'
  Mock 'article' expected :title with (any args) once, but received it 0 times



This fails because the mock article never receives the :title message. You can get this to pass like so …



  # in app/views/articles/list.rhtml
  

<%= @articles[0].title %>





So we're part of the way there, but what we want is for the view to iterate through the list. So add another spec …




    
    
    describe "articles/list with three articles" do
    before do
      articles = (1..3).inject([]) do |list, index|
        article = mock("article #{index}")
        article.should_receive(:title).and_return("example title #{index}")
        list << article
      end
      assigns[:articles] = articles
    end
    it "should display the title" do
      render 'articles/list'
      response.should have_tag("div", "example title 1")
      response.should have_tag("div", "example title 2")
      response.should have_tag("div", "example title 3")
    end
    end
    





... which produces …



  $ ruby spec/views/articles/list_view_spec.rb -fs

  articles/list with just one article
  - should display the title

  articles/list with three articles
  - should display the title (FAILED - 1)

  1)
  'articles/list with three articles should display the title' FAILED
  <"example title 2"> expected but was
  <"example title 1">.



It is failing on the second title because we're not yet iterating through the articles. So…



  <% for article in @articles %>
  

<%= article.title %>


  <% end %>



... and viola!



  $ ruby spec/views/articles/list_view_spec.rb -fs

  articles/list with just one article
  - should display the title

  articles/list with three articles
  - should display the title



As you can see, we are able to do this without any models or actions yet developed. As those get added, this spec will continue to pass because there is no dependency between it and the real models and controllers.





Now the risk here is that you could build a model that doesn't have a title field in it and your app will blow up! Admittedly, if you only write isolated, granular specs like this that risk is real. So you should be doing this in conjunction with integration testing. Unfortunately, RSpec 0.9 does not yet support any integration testing directly, but there are plenty of great tools that will handle that for you. If you want to keep it on the command line, use something like rails integration testing. If you like in-browser testing you can use watir or selenium.



