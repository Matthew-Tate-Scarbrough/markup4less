![John 21:20-22](https://raw.githubusercontent.com/Matthew-Tate-Scarbrough/markup4less/master/markup4less.png)

markup4less
===========

A glorified sed script that converts a LaTeX-like syntax and commands into ASNI-compatible commands;
it is intened to be used with `less -R`.

Included also are two examples; an "award-winning" short story that I wrote to test out some of the features, and an excerpt from the Gospel of John, to test colouring text and some italics, as well as underlinging.
The next section will explain the syntax, but just open the source code directory, and you can view these both by typing in:

    < example | ./syntax.sed | less -R
    < example2 | ./syntax.sed | less -R

or, alternatively, just:

    < example | ./syntax.sed
    < example2 | ./syntax.sed

will print them out to standard output in your terminal.


Syntax
------

Basically, it is very straightforward, though, due to keeping it as simple for just `GNU/sed` to handle, it isn't as easy as I would like, and I certainly don't mind writing an overly complex script in `gawk` or something in the future--but I don't know `awk` and that is honestly just bloat, so...

Basically, the sytax is thusly. In this example, we are creating bold-underlined text with a red background and white foreground.

    echo "{\bu;\bgred;\grey[Some example text...]}" | ./syntax | less -R
    
The commands should be able to go freely in any order.
The `{` is converted to the escape character for `less`;
the combinations of `\<letters>` are the actual commands;
the `;`'s are actual semicolons and are not touched by the script--tehy are necessary for separating multiple ANSI escape sequences;
the `[`'s are converted into the final `m` that denotes an ASNI escape sequence;
and finally, the `]}` is converted into the final `ESC+\0m`--it clears the commands out that come before it.

Basically, the script converts this to:

    \033[1;4;41;37mSome example text...\033[0m
    
Typing `\033` sadly does not work in `less`, it actually uses a special escape character, so the script was created for my convenience with that.
The actual syntax isn't that hard, but it may be hard to remember numbers, plus this front-end for them is a bit friendlier.
You don't have to know how or why it works, just that it works.

It probably goes without saying, that for files, you would do:

    < file | ./syntax | less -R


Commands
--------

The "documentation" is contained within the `sed` file itself, but I don't expect anyone to actually read that, so...
There are two categories of commands: *combos*, and *escape sequences*.
The only difference between them twain is that the combos are to make typing faster;
the semi-colons may be easy to forgot, and who really wants to type `{\bf;\it;\ul[`, when you could just type `{\ubt[` instead?

### Escape Sequences:

    \bd -	bold
    \bf -	bold-face (the LaTeX command for bold text)
    \it -	italics
    \em -	italics
    \ul -	underline
    \th -	thin
    \st -	strike-through
    \ol -	over-line
    \fm -	framed (draws a box around the text)
    \en -	encircle (draws a circle around the text)

### Combos:

    \bt   	    -	bold-italics
    \bif  	    -	bold-italics
    \stupid     -	bold-italics (personal joke--I hate bold-italics)
    \ut         -	underlined-italics
    \ult        -	underlined-italics
    \bu         -	bold-underlined
    \ub         -	bold-underlined
    \ubt        -	bold-underlined italics

### Text Colours:

You shouldn't have to manually change any of these, as these colours are usually defined in your terminal emulators config file/settings;
or they are overridden, I believe, within your shell's config file, if you so choose.
You literally shouldn't have to touch these at all.

    \black          -	30 (these are the ANSI-ESC colour codes)
    \red            -	31
    \green          -	32
                           
    \brown          -	33
    \orange         -	33
                           
    \blue           -	34
    \purple         -	35
    \cyan           -	36
                           
    \gray           -	37 (typing 'light' is bloat)
    \grey           -	37 (the superior spelling)
    \lightgray      -	37
    \lightgrey      -	37


### Highlight Colours:

These are literally the above commands, but with "bg-" prefixed, short for *background*.
Perhaps "hl-" makes more sense to you--that honestly never entered my mind, so...

    \bgblack    	-	40 (This one, I believe, actually just removed highlighting--it does not actually highlight in black.)
    \bgred          -	41
    \bggreen    	-	42
                           
    \bgbrown    	-	43
    \bgorange   	-	43
                           
    \bgblue         -	44
    \bgpurple       -	45
    \bgcyan   		-	46
                           
    \bggray         -	47
    \bggrey         -	47
    \bglightgray    -	47
    \bglightgrey    -	47


Known Bugs
----------

This is intended for long form text; interestingly, I actually wrote this for intent with use with {https://github.com/bontibon/kjv}[Bontibon's `kjv` program], so it is not intended for use with writing code or anything like that, so therefore the left square bracket (\[) and the left squiggly bracket (\{) are actually completely unusable.

I am sure there is something that can be done, such as changing it to `{[` and telling sed to look for `\b{[\b`, or perhaps adding `\b ... \b` around all the commands and escape all text brackets with `\[`, but I've yet to have a need for this, so it doesn't bother me--please, contribute if you can think of a solution.

Also, while not a "bug" per se, but `less` cannot display encircled or boxed text, but that may just be my terminal emulator.


Install
-------

I recommend putting all source code into its own dedicated folder where you can remember to find it--I personally prefer putting mine in `~/Downloads/.src`, and making subfolders within that, to organise things.

    mkdir -p ~/Downloads/.src
    git clone https://github.com/Matthew-Tate-Scarbrough/markup4less.git ~/Downloads/.src/mkp4lss

And from there, I would probably copy the `.sed` file into an easily callable location, such as `~/.bin/tools/sed/` and write a second shell script that calls it from that directory and pipes it output into `less` with the `-R` function enabled.
So, that would give you something like:

    #!/bin/sh
    
    .$HOME/.bin/tools/sed/syntax | less -R
    
Then you can just `sudo chmod +x` your new script and copy it into `/usr/local/bin/mynewscript`, then, whenever you need, you can just type into your terminal:

    < file | mynewscript
    
And it will just work.
