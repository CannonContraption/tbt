# Time Budget Tool

The Super Simple Timekeeping Tool

## Introduction

Throughout the course of the day, there's a lot more time to do things than is
obvious at first, at least for me. The best way to make the best of my time is
to map out what I'll be doing throughout the day, sometimes in as small as 5
minute intervals. At first I used a notebook, and this worked well. It did not,
however, adjust if I finished something quicker than I expected, or something 
took longer than I had hoped. Also, that takes a lot of paper.

After about a total of ten minutes of thought on the matter, I decided that my
computer was once again probably the right choice to handle this. Off to the
land of Emacs I went, and this is the result.

## Basic Concept

In order to facilitate time budgeting in a day (or smaller span of time), the
program uses a simple plain text format. The basic format can be described like
this:

    time	description

So as an example, if I wanted to budget out an hour or two's work cleaning a
desk, I might do so like this:

	10m	Sort desk contents into piles
	10m	sort papers (by rough type)
	20m	Go through papers to keep
	5m	Move recycle to bin
	5m	Cable wrap wires
	5m	sort tools/put away
	5m	Remove computer, monitors
	10m	clear off remainder of desk
	10m	Carefully clean surface
	10m	Rewire computer
	15m	redo layout on desk

and the program would return a neatly formatted schedule. Note the time starts
at 12:44AM (00:44) (That's what time it was when I ran this example) and counts
up with the tasks.

    /bin/zsh %>
    
    No.   │ in   │ Duration    │ Time   │ Description                  
    ──────┼──────┼─────────────┼────────┼────────────────────────────────╌╌┄┈
    1:    │ 0m   │ (0 h, 10 m) │ 00:44  │ Sort desk contents into piles
    2:    │ 10m  │ (0 h, 10 m) │ 0:54   │ sort papers (by rough type)
    3:    │ 20m  │ (0 h, 20 m) │ 1:4    │ Go through papers to keep
    4:    │ 40m  │ (0 h, 5 m)  │ 1:24   │ Move recycle to bin
    5:    │ 45m  │ (0 h, 5 m)  │ 1:29   │ Cable wrap wires
    6:    │ 50m  │ (0 h, 5 m)  │ 1:34   │ sort tools/put away
    7:    │ 55m  │ (0 h, 5 m)  │ 1:39   │ Remove computer, monitors
    8:    │ 60m  │ (0 h, 10 m) │ 1:44   │ clear off remainder of desk
    9:    │ 70m  │ (0 h, 10 m) │ 1:54   │ Carefully clean surface
    10:   │ 80m  │ (0 h, 10 m) │ 2:4    │ Rewire computer
    11:   │ 90m  │ (0 h, 15 m) │ 2:14   │ redo layout on desk
    
	/bin/zsh %>

If you complete something out of order, or took too long on something, or
finished something sooner than you had hoped, no big deal, go back into the
file with your tasks, remove the lines for things you've finished, and run tbt
again with your changes in place and you'll have a new set of time targets. No
paper wasted.

Note that the input syntax is quite rigid, the program won't parse your file 
right if you use spaces instead of tabs (\t) between the time estimation and
description.

## Advanced Syntax

The input file supports multiple input units. For example, you aren't just
limited to minutes, if you have a project in hours, you could write the line

    4h	Really Really long task

or in days (mostly unsupported since the time indicator does not roll over for
now)

    7d	Vacation. Stop looking at your tasks already.

## Planned features

Eventually, I want this to also include a simple shtbt interface (cli rather
than a command), and along with that commands to add items to a file and remove
completed ones as they get finished so that the list is always up to date and
current with expectations.
