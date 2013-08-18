---
author: David
comments: false
date: 2007-04-27 05:25:04+00:00
layout: post
slug: rspec-0-9-plug-in-any-mock-framework
title: rspec 0.9 - plug in any mock framework
wordpress_id: 25
---

RSpec-0.9 lets you work with the mock framework of your choice. It not only ships with adapters for mocha and flexmock, but it also provides you an easy entry point to plug in another framework of your choosing - or even your creation.






### rspec, mocha or flexmock






RSpec is the default mock framework, so if you want to use RSpec's mock framework you need not set anything up. If you want to use mocha or flexmock, just say





    
    <code>Spec::Runner.configure do |config|
    config.mock_with :mocha
    end
    </code>





or





    
    <code>Spec::Runner.configure do |config|
    config.mock_with :flexmock
    end
    </code>





Of course, if you're using mocha or flexmock you have to install those gems, but you don't need to require them because that is taken care of for you implicitly.






### Other mocking frameworks






If you have another mocking framework that you like to use, or one that you are developing yourself, you'll need to create an adapter for it like this:





    
    <code>module MyMockFrameworkAdapter
    def setup_mocks_for_rspec
      # Called before any #before(:each) blocks - use
      # this to set up any necessary hooks to your system.
    end
    def verify_mocks_for_rspec
      # Called after any #after(:each) blocks.
      # NOTE - your mocks should fail by raising an error.
    end
    def teardown_mocks_for_rspec
      # Called after verify_mocks_for_rspec. This
      # is guaranteed to run, even if there
      # are failures.
    end
    end
    </code>





And then include it using the new configuration system:





    
    <code>Spec::Runner.configure do |config|
    config.mock_with MyMockFrameworkAdapter
    end
    </code>
