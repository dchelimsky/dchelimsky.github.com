---
author: David
comments: false
date: 2006-11-06 23:03:57+00:00
layout: post
slug: bdd-specs-and-tests-together-again-at-last
title: BDD - specs and tests, together again at last
wordpress_id: 16
---

In discussing the 0.7 release of 'spec/rails', I find myself talking about how the model, view, controller and helper **specs** should be accompanied by integration **tests**. Those are the words that are emerging naturally. Admittedly, integration 'specs' just sounds silly to me!






This strikes me as interesting because we've been talking about wanting to eliminate the 'test' word from our BDD vocabulary, but as Dan North has pointed out, it keeps coming back.






What's emerging for me, however, is that it comes back in a different form. Perhaps the little bits we write in the TDD/BDD eeny-weeny red-green-refactor cycle are fundamentally different animals






But an evermore clear distinction emerges between the design activity of BDD in the small vs the customer collaboration activity of BDD in the large. (OK, medium to some of you)






In other words I think it's OK to use the word test when we talk about integration, system, whatever-higher-level tests. And it's OK to talk about specs when we talk about the details.
