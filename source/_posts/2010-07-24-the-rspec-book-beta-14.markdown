---
author: David
comments: true
date: 2010-07-24 01:58:41+00:00
layout: post
slug: the-rspec-book-beta-14
title: The RSpec Book - Beta 14
wordpress_id: 2660
categories:
- RSpec
- The RSpec Book
tag:
- rspec-2
- The RSpec Book
---

[The Pragmatic Bookshelf](http://www.pragprog.com/) has just released Beta-14 of [The RSpec Book](http://www.pragprog.com/titles/achbd/the-rspec-book).

This is the first beta release since we made the rather ambitious decision to update the book for RSpec-2 and Rails-3, and includes updates to the tutorial in Part I of the book, as well as the first chapter in Part III: Code Examples.

We're planning two more beta releases over the next couple of weeks. One to update the rest of Part III, and then a final beta release with Part V (the Rails section) updated to RSpec-2 and Rails-3.

What this means for the short run is that 1/2 of the beta book uses newer gem versions, while the rest uses the old versions. We thought for a long time about whether to delay this beta until it was all up to date, but decided in the end that beta readers had waited long enough---now that RSpec 2 and Rails 3 release candidates are just around the corner, we wanted to get this new content out as soon as we could. Keep in mind that this is only for a week or two, while we put the finishing touches on the book.

With that in mind, here is some information that will help you navigate the beta book:

### Ruby 1.8.7

The code examples in the book were written using Ruby 1.8.7. Most of them, but not all, will work with 1.9.2-rc2.

### Code for the updated chapters in beta-14

While we're getting these last few beta releases out, the updated chapters all have red headers, like this:

![Updated Section Header](http://blog.davidchelimsky.net/wp-content/uploads/2010/07/screen-shot-2010-07-23-at-75308-pm.png)

The examples in these chapters work with the following gem versions:

    rspec-2.0.0.beta.18
    cucumber-0.8.5

### Code for the rest of the chapters in beta-14

The chapters that have not been updated yet have gray headers, like this:

![Non-updated Section Header](http://blog.davidchelimsky.net/wp-content/uploads/2010/07/screen-shot-2010-07-23-at-75430-pm.png)

The examples in these chapters work with the following gem versions:

    rspec-1.3.0
    rspec-rails-1.3.2
    rails-2.3.5
    cucumber-0.6.2
    cucumber-rails-0.2.4
    database_cleaner-0.4.3
    webrat-0.7.0
    selenium-client-0.2.18


### Reporting Errata

#### Technical errors in the updated chapters

We are now in the final phases of preparing the book for print. For those of you reading the beta book, we are very interested in _technical errata in the updated chapters_. If the behaviour of any examples in the updated chapters differs from what the book tells you to expect _with the versions listed above_, please report that to [http://www.pragprog.com/titles/achbd/errata](http://www.pragprog.com/titles/achbd/errata).

#### Copyedit issues

The book has not been through copyedit yet (that's next), so please don't worry about spelling, grammar, or phrasing. That will all be addressed by our very able copyeditor.

#### Typesetting issues

The book has not been formally typeset yet (that's last), so please don't worry about code examples that span page turns, or issues with syntax highlighting.

#### Other technical errors

If you find that the behaviour works differently with newer Ruby or gem versions than those listed above, please submit bug reports to the appropriate trackers:

 * [rspec-core (describe/it/etc)](http://github.com/rspec/rspec-core)
 * [rspec-expectations (should/should_not + matchers)](http://github.com/rspec/rspec-expectations)
 * [rspec-mocks](http://github.com/rspec/rspec-mocks)
 * [rspec-rails](http://github.com/rspec/rspec-rails)
 * [cucumber](http://rspec.lighthouseapp.com/projects/16211)

