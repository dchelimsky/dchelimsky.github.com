---
author: David
comments: true
date: 2010-06-24 11:23:57+00:00
layout: post
slug: why-you-want-a-topic-branch-when-contributing-to-git-hosted-projects
title: Why you want a topic branch when contributing to git-hosted projects
wordpress_id: 2639
---

When contributing to a git(hub)-hosted open source project, it is often recommended that you follow these steps:

* fork the repo
* make changes on a topic branch
* push the branch to your repo
* send a pull request or link to the commit from a ticket

I was recently asked whether the topic branch in step 2 was necessary. The answer is that it's not really necessary, it just makes life easier for both the contributor and the maintainer. Here's why.

When maintainers merge patches, they often modify commit messages: rewording for consistency in the commit logs, sign-off statements, etc. They'll also sometimes change the actual content of the commit to fix typos, reorganize methods in a file, etc, etc.

In either case, the result is that the commit that gets merged to the mainline repo has a different sha1 than the commit you submitted. This means that when you go to merge the mainline master branch back into your master branch, you'll run into conflicts. Then, if you resolve them, the HEAD of your master branch is not the same as the HEAD of the mainline master branch, so the next patch you submit off your master branch will likely not apply easily.

By keeping your patches on topic branches, you're able to keep your master branch aligned with the mainline master branch. This makes it easier for you to submit more patches later. It also makes it more likely that your contributions will apply cleanly, which increases the likelihood that they'll be accepted.
