---
author: David
comments: false
date: 2008-07-01 05:02:07+00:00
layout: post
slug: new-controller-examples
title: new controller examples
wordpress_id: 68
---

There's been a lot of discussion about _clarity over DRY_ lately. This is something that I've been espousing for some time, but recent posts by [Jay Fields](http://blog.jayfields.com/2008/05/testing-duplicate-code-in-your-tests.html), [Mikel Lindsaar](http://lindsaar.net/2008/6/24/tip-24-being-clever-in-specs-is-for-dummies) and [Dan North](http://dannorth.net/2008/06/let-your-examples-flow) have gotten me thinking about it again with more focus.

With this in mind, I've been refining the examples generated for restful controllers when you run `script/generate rspec_scaffold` with the [rspec-rails](http://github.com/dchelimsky/rspec-rails) plugin. I've got them now where I'm pretty happy with them, but I'm curious to hear what you think. I'm not going to tell you what I changed or what to look for, I'm just going to ask you to look it over and post your comments.

There are two listings: the generated code and the output you get from running the examples. Thanks in advance for any feedback.



### script/generate rspec_scaffold account





    
    
    require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
    
    describe AccountsController do
    
    def mock_account(stubs={})
      stubs = {
        :save => true,
        :update_attributes => true,
        :destroy => true,
        :to_xml => ''
      }.merge(stubs)
      @mock_account ||= mock_model(Account, stubs)
    end
    
    describe "responding to GET /accounts" do
    
      it "should succeed" do
        Account.stub!(:find)
        get :index
        response.should be_success
      end
    
      it "should render the 'index' template" do
        Account.stub!(:find)
        get :index
        response.should render_template('index')
      end
    
      it "should find all accounts" do
        Account.should_receive(:find).with(:all)
        get :index
      end
    
      it "should assign the found accounts for the view" do
        Account.should_receive(:find).and_return([mock_account])
        get :index
        assigns[:accounts].should == [mock_account]
      end
    
    end
    
    describe "responding to GET /accounts.xml" do
    
      before(:each) do
        request.env["HTTP_ACCEPT"] = "application/xml"
      end
    
      it "should succeed" do
        Account.stub!(:find).and_return([])
        get :index
        response.should be_success
      end
    
      it "should find all accounts" do
        Account.should_receive(:find).with(:all).and_return([])
        get :index
      end
    
      it "should render the found accounts as xml" do
        Account.should_receive(:find).and_return(accounts = mock("Array of Accounts"))
        accounts.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end
    
    describe "responding to GET /accounts/1" do
    
      it "should succeed" do
        Account.stub!(:find)
        get :show, :id => "1"
        response.should be_success
      end
    
      it "should render the 'show' template" do
        Account.stub!(:find)
        get :show, :id => "1"
        response.should render_template('show')
      end
    
      it "should find the requested account" do
        Account.should_receive(:find).with("37")
        get :show, :id => "37"
      end
    
      it "should assign the found account for the view" do
        Account.should_receive(:find).and_return(mock_account)
        get :show, :id => "1"
        assigns[:account].should equal(mock_account)
      end
    
    end
    
    describe "responding to GET /accounts/1.xml" do
    
      before(:each) do
        request.env["HTTP_ACCEPT"] = "application/xml"
      end
    
      it "should succeed" do
        Account.stub!(:find).and_return(mock_account)
        get :show, :id => "1"
        response.should be_success
      end
    
      it "should find the account requested" do
        Account.should_receive(:find).with("37").and_return(mock_account)
        get :show, :id => "37"
      end
    
      it "should render the found account as xml" do
        Account.should_receive(:find).and_return(mock_account)
        mock_account.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "1"
        response.body.should == "generated XML"
      end
    
    end
    
    describe "responding to GET /accounts/new" do
    
      it "should succeed" do
        get :new
        response.should be_success
      end
    
      it "should render the 'new' template" do
        get :new
        response.should render_template('new')
      end
    
      it "should create a new account" do
        Account.should_receive(:new)
        get :new
      end
    
      it "should assign the new account for the view" do
        Account.should_receive(:new).and_return(mock_account)
        get :new
        assigns[:account].should equal(mock_account)
      end
    
    end
    
    describe "responding to GET /accounts/1/edit" do
    
      it "should succeed" do
        Account.stub!(:find)
        get :edit, :id => "1"
        response.should be_success
      end
    
      it "should render the 'edit' template" do
        Account.stub!(:find)
        get :edit, :id => "1"
        response.should render_template('edit')
      end
    
      it "should find the requested account" do
        Account.should_receive(:find).with("37")
        get :edit, :id => "37"
      end
    
      it "should assign the found Account for the view" do
        Account.should_receive(:find).and_return(mock_account)
        get :edit, :id => "1"
        assigns[:account].should equal(mock_account)
      end
    
    end
    
    describe "responding to POST /accounts" do
    
      describe "with successful save" do
    
        it "should create a new account" do
          Account.should_receive(:new).with({'these' => 'params'}).and_return(mock_account)
          post :create, :account => {:these => 'params'}
        end
    
        it "should assign the created account for the view" do
          Account.stub!(:new).and_return(mock_account)
          post :create, :account => {}
          assigns(:account).should equal(mock_account)
        end
    
        it "should redirect to the created account" do
          Account.stub!(:new).and_return(mock_account)
          post :create, :account => {}
          response.should redirect_to(account_url(mock_account))
        end
    
      end
    
      describe "with failed save" do
    
        it "should create a new account" do
          Account.should_receive(:new).with({'these' => 'params'}).and_return(mock_account(:save => false))
          post :create, :account => {:these => 'params'}
        end
    
        it "should assign the invalid account for the view" do
          Account.stub!(:new).and_return(mock_account(:save => false))
          post :create, :account => {}
          assigns(:account).should equal(mock_account)
        end
    
        it "should re-render the 'new' template" do
          Account.stub!(:new).and_return(mock_account(:save => false))
          post :create, :account => {}
          response.should render_template('new')
        end
    
      end
    
    end
    
    describe "responding to PUT /accounts/1" do
    
      describe "with successful update" do
    
        it "should find the requested account" do
          Account.should_receive(:find).with("37").and_return(mock_account)
          put :update, :id => "37"
        end
    
        it "should update the found account" do
          Account.stub!(:find).and_return(mock_account)
          mock_account.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "1", :account => {:these => 'params'}
        end
    
        it "should assign the found account for the view" do
          Account.stub!(:find).and_return(mock_account)
          put :update, :id => "1"
          assigns(:account).should equal(mock_account)
        end
    
        it "should redirect to the account" do
          Account.stub!(:find).and_return(mock_account)
          put :update, :id => "1"
          response.should redirect_to(account_url(mock_account))
        end
    
      end
    
      describe "with failed update" do
    
        it "should find the requested account" do
          Account.should_receive(:find).with("37").and_return(mock_account(:update_attributes => false))
          put :update, :id => "37"
        end
    
        it "should update the found account" do
          Account.stub!(:find).and_return(mock_account)
          mock_account.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "1", :account => {:these => 'params'}
        end
    
        it "should assign the found account for the view" do
          Account.stub!(:find).and_return(mock_account(:update_attributes => false))
          put :update, :id => "1"
          assigns(:account).should equal(mock_account)
        end
    
        it "should re-render the 'edit' template" do
          Account.stub!(:find).and_return(mock_account(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end
    
      end
    
    end
    
    describe "responding to DELETE /accounts/1" do
    
      it "should find the account requested" do
        Account.should_receive(:find).with("37").and_return(mock_account)
        delete :destroy, :id => "37"
      end
    
      it "should call destroy on the found account" do
        Account.stub!(:find).and_return(mock_account)
        mock_account.should_receive(:destroy)
        delete :destroy, :id => "1"
      end
    
      it "should redirect to the accounts list" do
        Account.stub!(:find).and_return(mock_account)
        delete :destroy, :id => "1"
        response.should redirect_to(accounts_url)
      end
    
    end
    
    end
    





### script/spec spec/controllers/accounts_controller_spec.rb -fn





    
    
    AccountsController
    responding to GET /accounts
      should succeed
      should render the 'index' template
      should find all accounts
      should assign the found accounts for the view
    responding to GET /accounts.xml
      should succeed
      should find all accounts
      should render the found accounts as xml
    responding to GET /accounts/1
      should succeed
      should render the 'show' template
      should find the requested account
      should assign the found account for the view
    responding to GET /accounts/1.xml
      should succeed
      should find the account requested
      should render the found account as xml
    responding to GET /accounts/new
      should succeed
      should render the 'new' template
      should create a new account
      should assign the new account for the view
    responding to GET /accounts/1/edit
      should succeed
      should render the 'edit' template
      should find the requested account
      should assign the found Account for the view
    responding to POST /accounts
      with successful save
        should create a new account
        should assign the created account for the view
        should redirect to the created account
      with failed save
        should create a new account
        should assign the invalid account for the view
        should re-render the 'new' template
    responding to PUT /accounts/1
      with successful update
        should find the requested account
        should update the found account
        should assign the found account for the view
        should redirect to the account
      with failed update
        should find the requested account
        should update the found account
        should assign the found account for the view
        should re-render the 'edit' template
    responding to DELETE /accounts/1
      should find the account requested
      should call destroy on the found account
      should redirect to the accounts list
    
