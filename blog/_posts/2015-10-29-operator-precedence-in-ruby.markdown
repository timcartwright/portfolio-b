---
layout: post
title:  "Operator Precedence in Ruby"
date:   2015-10-29 05:33:38
image:	operator-precedence.jpg
categories:  blog
tags: 	ruby
---
<h3>|| or or and && and and</h3>

Symbolic: && , ||
English: and, or

Synonimous here:

false || 52  => 52
nil && 52 => nil

false or 52 => 52
nil and 52 => nil

BUT

x || y && nil => x

x or y and nil => nil

WHY

Operator precedence: https://gist.github.com/timcartwright/748ca09b79fb50834fa5

Effectively:

x || (y && nil) => x

(x or y) and nil => nil
