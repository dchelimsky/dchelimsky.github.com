---
author: David
comments: false
date: 2007-10-26 14:30:14+00:00
layout: post
slug: lessons-in-specing
title: Lessons in Spec'ing
wordpress_id: 46
---

Lesson: system calls in specs do stuff on your system. Be careful.






I was trying different things to understand why a spec was failing and, at one point, put a pending statement in a spec that generates a file and then deletes it. The statement that deletes the file is in an after(:each) block (which is guaranteed to run) and looks like this:





    
    <code>system(%Q|rm "#{dir}/#{filename}"|)</code>





Imagine my horror when I saw this in the output:





    
    rm: /: is a directory
