---
author: David
comments: false
date: 2007-03-02 16:30:43+00:00
layout: post
slug: lesson-learned-dont-fork-a-moving-target
title: lesson learned - don't fork a moving target
wordpress_id: 21
---

In rspec-0.8.0, I forked assert_select in order to get the desired rspec syntax and error messages. Yesterday, only a day after the 0.8.1 release, the specs for "response.should have_rjs" (rspec's assert_select_rjs port) started failing against edge rails.






It didn't take me very long to realize that forking assert_select (and its siblings - assert_select_rjs, assert_select_email, etc) was a big mistake. The only thing that is really maintainable is a very thin wrapper. As long as the API doesn't change, the wrapper should continue to work correctly.






So I re-wrote have_tag, with_tag (for nested tags), have_rjs, be_feed and send_email to simply delegate off to assert_select - exactly as i.should have_done in the first place. This rewrite will be released with 0.8.2, probably later today.






Unfortunately, this does introduce a regression. Currently, assert_select_rjs does not support :hide or :effect, so these won't be supported by should have_rjs.






In the short term, you'll still be able to spec :hide and :effect using the now deprecated should_have_rjs, and hopefully we'll be able to come up w/ some solution for should have_rjs(:hide/:effect) before 0.9, when we are slated to remove all the deprecated features.
