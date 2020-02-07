#!/bin/sh
#
# Due to how complex the ANSI escape sequences are, they need to be nested; unfortunately,
# this means the syntax will have to be a bit different from how I wanted it to be, but it is doable.
#
#	e.g. {\opt1;\opt2;\opt3[<text>]}
#
#	i.e. {\it;\bd;\ul[Who has authority? who can answer the question? who can bring water to the wasteland?]}
#
# Escape Sequences:
#
#	\bd	-	bold
#	\bf	-	bold
#	\it	-	italics
#	\em	-	italics
#	\ul	-	underline
#	\th	-	thin
#	\st	-	strike-through
#	\ol	-	over-line
#	\fm	-	framed (draws a box around the text)
#	\en	-	encircle (draws a circle around the text)
#
#
# Combos:
#
#	\bt	-	bold-italics
#	\bif	-	bold-italics
#	\stupid	-	bold-italics
#	\ut	-	underlined-italics
#	\ult	-	underlined-italics
#	\bu	-	bold-underlined
#	\ub	-	bold-underlined
#	\ubt	-	bold-underlined italics
#
#
# Colours (Text):
#
#	\black		-	30
#	\red		-	31
#	\green		-	32
#
#	\brown		-	33
#	\orange		-	33
#
#	\blue		-	34
#	\purple		-	35
#	\cyan		-	36
#
#	\gray		-	37
#	\grey		-	37
#	\lightgray	-	37
#	\lightgrey	-	37
#
#
# Background Colours:
#
#	\bgblack	-	40
#	\bgred		-	41
#	\bggreen	-	42
#
#	\bgbrown	-	43
#	\bgorange	-	43
#
#	\bgblue		-	44
#	\bgpurple	-	45
#	\bgcyan		-	46
#
#	\bggray		-	47
#	\bggrey		-	47
#	\bglightgray	-	47
#	\bglightgrey	-	47
#
#
# For colours plus combination escape sequences, you still need to supply semicolons after them IF a colour or
# such is paired with it:
#
#	e.g. {\ubt;\red[Where can I go to find refuge? who else has claim to this truth?]}

sed '
# beginny-emmy-thingy
s/\[/m/g
# endy-emmy-thingy
s/\]}/\[0m/g
# Escape Character
s/{/\[/g
# Combos
s/\\bt/1\;3/g
s/\\bif/1\;3/g
s/\\stupid/1\;3/g
s/\\ut/3\;4/g
s/\\ult/3\;4/g
s/\\bu/1\;4/g
s/\\ub/1\;4/g
s/\\ubt/1\;3\;4/g
# Escape Sequences
s/\\bd/1/g
s/\\bf/1/g
s/\\th/2/g
s/\\it/3/g
s/\\em/3/g
s/\\ul/4/g
s/\\st/9/g
s/\\fm/51/g
s/\\en/52/g
s/\\ol/53/g
# Colours
s/\\black/30/g
s/\\red/31/g
s/\\green/32/g
s/\\brown/33/g
s/\\orange/33/g
s/\\blue/34/g
s/\\purple/35/g
s/\\cyan/36/g
s/\\gray/37/g
s/\\grey/37/g
s/\\lightgray/37/g
s/\\lightgrey/37/g
# Background Colours
s/\\bgblack/40/g
s/\\bgred/41/g
s/\\bggreen/42/g
s/\\bgbrown/43/g
s/\\bgorange/43/g
s/\\bgblue/44/g
s/\\bgpurple/45/g
s/\\bgcyan/46/g
s/\\bggray/47/g
s/\\bggrey/47/g
s/\\bglightgray/47/g
s/\\bglightgrey/47/g
'
