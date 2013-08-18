---
author: David
comments: false
date: 2007-04-01 13:58:50+00:00
layout: post
slug: rspec-plays-nice-with-others
title: RSpec plays nice with others
wordpress_id: 23
---

RSpec 0.9 is coming soon, and promises to do a better job of playing nice with others.






#### RSpec plays nice with you.






There's a new configuration mechanism inspired by the one in Rails:





    
    <code>Spec::Runner.configure do |config|
    config.use_transactional_fixtures = true
    #etc
    end
    </code>





This mostly affects Spec::Rails users, but as new features become configurable, this will be the "how".






#### RSpec plays nice with mocha.






Update 4/25 - 0.9 will be released with support for flexmock as well as mocha.






Speaking of new configurable features, RSpec 0.9 will play nice with other mock frameworks. The first release is going to support using mocha, but we're hoping to follow this with support for flexmock as well. So now, in a spec_helper.rb, you can do this:





    
    <code>Spec::Runner.configure do |config|
    config.mock_with :mocha
    end
    </code>





This tells RSpec to load up mocha instead of RSpec's mock framework, Spec::Mocks. One nice thing about using mocha with RSpec is that, in my opinion, the different syntax illuminates the different semantics:








  * #expects for pre-action, interaction expectations

  
  * #should for post-action, (typically) state expectations






Sure, we could get similar syntax by aliasing #should_receive, but there are a lot of people who simply prefer mocha or flexmock and we want to invite them all to use RSpec without giving up their preferred mocking framework.






#### RSpec even plays nice with 'test/unit'






For some time now, RSpec has allowed you to bring the myriad plugins and add-ons associated with 'test/unit' by deriving the binding in which examples are run from Test::Unit::TestCase (like so…)





    
    <code>describe Thing do
    inherit Test::Unit::TestCase
    #...
    end
    </code>





With RSpec 0.9, we've added the reverse: Spec::Expectations and Spec::Matchers made available to your 'test/unit' tests with a simple require statement:





    
    <code>require 'test/unit'
    require 'spec/test_case_adapter'
    
    class ThingTest < Test::Unit::TestCase
    def setup
      @thing = Thing.new
    end
    
    def test_thing_should_be_friendly
      @thing.should be_friendly
    end
    end
    </code>





#### RSpec plays nice with your diet






With RSpec 0.9, RSpec is finally sugar-free!






We'll miss the underscores that followed #should, and I'm personally grateful to Rich Kilmer for the very, very cool patch that not only allowed us to eliminate all of those nasty dots, but taught me one of my first serious lessons in meta-programming. However, as time went on we discovered that continuing to support that sugar was going to be an ongoing struggle between RSpec and any system it was being used to describe that happened to like #method_missing as much as RSpec did. And so we bid it a bittersweet "adieu".






Of course, if you're missing some sweetener, there's always the natural sweeteners in mocha ….






Describe it with RSpec-0.9. Coming soon to a gems directory near you.
