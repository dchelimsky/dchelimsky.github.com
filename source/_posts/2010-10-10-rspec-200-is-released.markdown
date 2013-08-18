---
author: David
comments: true
date: 2010-10-10 22:45:54+00:00
layout: post
slug: rspec-200-is-released
title: RSpec-2.0.0 is released!
wordpress_id: 2683
categories:
- BDD
- Cucumber
- RSpec
- Rails
---

This marks the end of a year-long effort that improves RSpec in a number of ways, including [modularity, cleaner code, and much better integration with Rails-3 than was possible before](http://blog.davidchelimsky.net/2010/01/25/rspec-20-in-the-works/).




### Docs, with a little bit of relish




In addition to the documentation available at all the places mentioned [my earlier post](http://blog.davidchelimsky.net/2010/07/01/rspec-2-documentation/), we've also got all of the [Cucumber](http://github.com/aslakhellesoy/cucumber) features posted to Justin Ko's new Cucumber presentation app, relish.




[http://relishapp.com/rspec](http://relishapp.com/rspec)




We'll also have the RDoc up on [http://rdoc.info](http://rdoc.info) in a day or so.




### Thanks!




Big thanks to 80+ contributors who submitted patches for RSpec-2.0.0, including [1]:




Aan, Adam Walters, Akira Matsuda, Alex Crichton, Anderson Dias, Andre Arko, Andreas Neuhaus, Ashley Moran, Ben Armston, Ben Rady, Brasten Sager, Brian J Reath, Carlhuda, Chad Humphries, Charles Lowell, Chris Redinger, Chuck Remes, Corey Ehmke, Corey Haines, Dan Peterson, Dave Newman, David Genord II, David S. Kang, Ethan Gunderson, Gonçalo Silva, Greg Sterndale, Hans de Graaff, Iain Hecker, Jacques Crocker, Jean-Daniel Guyot, Jeff Ramnani, Jim Breen, Johan Kiviniemi, Josep Mª Bach, Josh Graham, Joshua Nichols, Kabari Hendrick, Kristian M, Lailson B, Len Smith, Leonardo Bessa, Les Hill, Luis Lavena, Marcin Kulik, Markus Schirp, Matt Remsik, Matt Yoho, Matthew Todd, Michael Niessner, Mike Gehard, Myron Marston, Nate Jackson, Neeraj Singh, Nestor Ovroy, Nick Ang, Nicolas Braem, Paul Rosania, Phil Smith, Postmodern, Prasad, Rob Sanheim, Roman Chernyatchik, Ryan Bigg, Ryan Briones, Sam Pohlenz, Scott Taylor, Shin-ichiro OGAWA, Thibaud Guillaume-Gentil, Tim Connor, Tim Harper, Tom Stuart, Vít Ondruch, Wincent Colaiuta, aslakhellesoy, eira, garren smith, grosser, hasimo, justinko, rup, speedmax, wycats




Extra special thanks go to:






  * Chad Humphries for contributing his Micronaut gem which is the basis for rspec-core-2


  * Yehuda Katz, Carl Lerche, and José Valim, for their assistance with getting rspec-rails-2 to take advantage of new APIs in Rails-3, and for shepherding patches to Rails that made it far simpler for testing extensions like rspec-rails to hook into Rails' testing infrastructure. Their work here has significantly reduced the risk that Rails point-releases will break rspec-rails.


  * Myron Marston for a wealth of thoughtful contributions including Cucumber features that we can all learn from


  * Justin Ko for his direct contributions to rspec, and for [relish](http://relishapp.com/), which makes executable documentation act more like documentation.




### What's next?




#### rspec-rails-2 for rails-2




There are a couple of projects floating around that support rspec-2 and rails-2. I haven't had the chance to review any of these myself, but my hope is that we'll have be an official rspec-2 for rails-2 gem in the coming months.




#### rspec-1 maintenance




rspec-1 will continue to get maintenance releases, but these will be restricted, primarily, to bug fixes. Any new features will go into rspec-2, and will likely not be back-ported.




[1] Contributor names were generated from the git commit logs.



