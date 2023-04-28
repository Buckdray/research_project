globals [
  %vulnerable
  ;region-boundaries ; a list of regions definitions, where each region is a list of its min pxcor and max pxcor
payout-range-list
  breach-history-list
  awareness-list
  time-on-bbp-list
  vulnerability-history-list
  num-of-bugs-list

] ;;global variable vulnerable created

patches-own [
  region; the number of the region that the patch is in, patches outside all regions have region = 0
]




;create breeds in the environment for bug bounty programs, companies, and security researchers.

;breed [bugbountyprograms bbp] ;check this, removed bug bounty programs,
breed [companies company]
breed [securityResearchers researcher]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;               Properties for the breeds above

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;bugbountyprograms-own [ ; check this
;  payoutCapability
;  reliability
;  oligopoly
;  responsetime ;
;  modeOfOperation ; whiteHat and blackHat
;]

companies-own [
  payoutRange;
  awareness;
  vulnerabilityHistory ;vulnerabilities found during
  breachHistory;
  timeOnBBP;
  num-of-bugs;
]


securityResearchers-own [
  abilityToFindBugs
  knowledgeLevel
  speedToAnalyze
  platformKnowledge
  honesty? ; measure of honesty and dishonesty of
  motivation ;pride,vanity,brandInterest,
  accessToResources
  availabilityToResearch
  experienceLevel
  creativity
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;             Create the environment

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to setup
  clear-all

  ;setup-regions number-of-regions
  ; Color all the regions differently. In your own
  ; model, things would probably look different
  ;color-regions


  ;;old function bugbountyprograms ;; link with the bbp programs created
;  create-researchers researchers ;;create turtles
;  [
;    setxy random-xcor random-ycor;;where the turtles will be placed
;    set shape "bug"
;    set color red
;    set size 1
;  ]
;
;  create-turtles
;  ;ask turtle 1 [set color green set shape "face happy"]
;  ;set %vulnerable (count turtles with [color = green]/ count turtles) * 100


  ;;;createBugBountyProgram

  create-companies num-of-companies[
    set color red
    set shape "circle"
    set size  4
    setxy random-xcor random-ycor



  ]
  create-securityResearchers num-of-researchers[

    set color green
    set size  2
    setxy random-xcor random-ycor

  ]
  ;; set properties for the breeds
  randomize

  implement-randomizedValues-on-breeds

  ask companies [
    set label (word "CID: " who " - Bugs: " num-of-bugs)

  ]

  reset-ticks

end

to randomize
 ;;Randomize for companies
 set payoutRange-rate random 100;to remove
 set breachHistory-rate random 100; to remove
 set awareness-rate random 100; to remove
 set timeOnBBP-rate random 100; to remove
 set vulnerabilityHistory-rate random 100; to remove
 set num-of-bugs-rate random 100; to remove

 ;;Randomize for securityResearchers
 set abilityToFindBugs-rate random 100
  set platformKnowledge-rate random 100
  set availabilityToResearch-rate random 100
  set knowledgeLevel-rate random 100
  set motivation-rate random 100
  set experienceLevel-rate random 100
  set speedToAnalyze-rate random 100
  set accessToResources-rate random 100
  set creativity-rate random 100
end



to implement-randomizedValues-on-breeds
  ;; set company breed properties
  set payout-range-list n-values 20 [random 100]
  set breach-history-list n-values 20 [random 100]
  set awareness-list n-values 20 [random 100]
  set time-on-bbp-list n-values 20 [random 100]
  set vulnerability-history-list n-values 20 [random 100]
  set num-of-bugs-list n-values 20 [random 100]
  ;;look at how to randomize the n-values or if there's any significance to it


  ask companies [
    ;set for this case we will have to provide a list of values for each company. investigate how to make it more randomized;

    set payoutRange one-of payout-range-list;
    show payoutRange
    set breachHistory one-of breach-history-list;
    set awareness one-of awareness-list;
    set timeOnBBP one-of time-on-bbp-list;
    set vulnerabilityHistory one-of vulnerability-history-list;vulnerabilities found during
    set num-of-bugs one-of num-of-bugs-list

   ]
   ;figure out a way to randomize company links as well, should be dynamically linked to the number of companies placed in the environment.
   let num-links random count companies  ;
   ;show num-links
   ;ask n-of num-links companies [
  ;ask n-of 2 companies [
   ; create-links-with other n-of 2 companies with [self != myself]
  ;] hold off on the links part of the bug bounty problem


  ;; set securityResearchers breed properties
  ask securityResearchers [
    ;set breed-property value;
    set abilityToFindBugs abilityToFindBugs-rate;
    ;show abilityToFindBugs
    set platformKnowledge platformKnowledge-rate;
    set availabilityToResearch availabilityToResearch-rate
    set knowledgeLevel knowledgeLevel-rate
    set motivation motivation-rate
    set experienceLevel experienceLevel-rate
    set speedToAnalyze speedToAnalyze-rate
    set accessToResources accessToResources-rate
    set creativity creativity-rate
  ]
end

to go
  tick ;; time system to advance by 1 day
  ;;ask turtles ;; ask the turtles to move around , move in diferent directions randomly
  ask turtles with [color = green]
    [rt random 100 lt random 100 fd 1] ;;move right 100 steps , 100 to the left , 1 step forward
  ask turtles with [color = green]

    [
      ask other turtles-here [
        if random 20 < %effectiveness  ;;command turtles that are touching if a random number is less that what has been specified then turn it green(fixed)
        [
         set color green
         set shape "face happy"
         set size 1
        ]
      ]
    ]
  set %vulnerable (count turtles with [color = red]/ count turtles) * 100 ;; defining the infected variable.
  if %vulnerable = 0 [stop] ;; if all are safe then end the simulation
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;             Creating the regions representing bug bounty programs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;to setup-regions [ num-regions ]
;  ; First, draw some dividers at the intervals reported by `region-divisions`:
;  foreach region-divisions num-regions draw-region-division
;  ; Store our region definitions globally for faster access:
;  set region-boundaries calculate-region-boundaries num-regions
;
;  ; Set the `region` variable for all patches included in regions:
;
;  let region-numbers (range 1 (num-regions + 1))
;
;  (foreach region-boundaries region-numbers [ [boundaries region-number] ->
;
;    ask patches with [ pxcor >= first boundaries and pxcor <= last boundaries ] [
;
;      set region region-number
;
;    ]
;
;  ])
;end
;
;
;to-report region-divisions [ num-regions ]
;
;  ; This procedure reports a list of pxcor that should be outside every region.
;  ; Patches with these pxcor will act as "dividers" between regions.
;
;  report n-values (num-regions + 1) [ n ->
;
;    [ pxcor ] of patch (min-pxcor + (n * ((max-pxcor - min-pxcor) / num-regions))) 0
;
;  ]
;
;end
;
;
;to draw-region-division [ x ]
;
;  ; This procedure makes the division patches grey
;
;  ; and draw a vertical line in the middle. This is
;
;  ; arbitrary and could be modified to your liking.
;
;  ask patches with [ pxcor = x ] [
;
;    set pcolor grey + 1.5
;
;  ]
;
;  create-turtles 1 [
;
;    ; use a temporary turtle to draw a line in the middle of our division
;
;    setxy x max-pycor + 0.5
;
;    set heading 0
;
;    set color grey - 3
;    pen-down
;    forward world-height
;
;    set xcor xcor + 1 / patch-size
;
;    right 180
;
;    set color grey + 3
;
;    forward world-height
;
;    die ; our turtle has done its job and is no longer needed
;
;  ]
;
;end
;
;
;
;to-report calculate-region-boundaries [ num-regions ]
;
;  ; The region definitions are built from the region divisions:
;
;  let divisions region-divisions num-regions
;
;  ; Each region definition lists the min-pxcor and max-pxcor of the region.
;
;  ; To get those, we use `map` on two "shifted" copies of the division list,
;
;  ; which allow us to scan through all pairs of dividers
;
;  ; and built our list of definitions from those pairs:
;
;  report (map [ [d1 d2] -> list (d1 + 1) (d2 - 1) ] (but-last divisions) (but-first divisions))
;
;end
;
;to color-regions
;
;  ; The patches with region = 0 act as dividers and are
;
;  ; not part of any region. All other patches get colored
;
;  ; according to the region they're in.
;
;  ask patches with [ region != 0 ] [
;
;    set pcolor 2 + region * 10
;
;    set plabel-color pcolor + 1
;
;    set plabel region
;
;  ]
;
;end
;
;
;;to bugbountyprograms
;;  ;; patch procedure
;;  ;; setup BBP1 one on the right
;;  ask patches [if (distancexy (0.6 * max-pxcor) 0) < 5
;;  [ set pcolor green ]
;;  ;; setup BBP2 on the lower-left
;;  if (distancexy (-0.6 * max-pxcor) (-0.6 * max-pycor)) < 5
;;  [ set pcolor orange ]
;;  ;; setup BBP3 on the upper-left
;;  if (distancexy (-0.7 * max-pxcor) (0.7 * max-pycor)) < 5
;;  [ set pcolor violet ]
;;  ]
;;end
@#$#@#$#@
GRAPHICS-WINDOW
1329
10
2051
733
-1
-1
17.42424242424243
1
10
1
1
1
0
1
1
1
-20
20
-20
20
0
0
1
ticks
30.0

BUTTON
1017
66
1083
99
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
111
38
174
71
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
13
93
186
126
num-of-researchers
num-of-researchers
2
80
4.0
1
1
NIL
HORIZONTAL

SLIDER
12
288
184
321
%effectiveness
%effectiveness
0
25
25.0
1
1
NIL
HORIZONTAL

PLOT
10
385
210
535
Hacker Effectiveness 
days
successful bounties 
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot %vulnerable"

MONITOR
17
556
178
601
% of Vulnerable Systems
%vulnerable
17
1
11

MONITOR
15
616
72
661
Days
ticks
0
1
11

SLIDER
391
106
597
139
reliability-rate
reliability-rate
0
100
92.0
1
1
NIL
HORIZONTAL

SLIDER
391
176
597
209
payoutCapability-rate
payoutCapability-rate
0
100
61.0
1
1
NIL
HORIZONTAL

SLIDER
391
254
598
287
responsetime-rate
responsetime-rate
0
100
100.0
1
1
NIL
HORIZONTAL

TEXTBOX
260
114
410
142
Bug Bounty Program Properties
11
0.0
1

SLIDER
393
339
597
372
abilityToFindBugs-rate
abilityToFindBugs-rate
0
100
45.0
1
1
NIL
HORIZONTAL

SLIDER
392
412
598
445
knowledgeLevel-rate
knowledgeLevel-rate
0
100
84.0
1
1
NIL
HORIZONTAL

TEXTBOX
260
338
410
366
Security Researcher Properties
11
0.0
1

TEXTBOX
535
230
685
248
NIL
11
0.0
1

TEXTBOX
242
554
392
582
Software Company Properties \n
11
0.0
1

SLIDER
391
549
598
582
payoutRange-rate
payoutRange-rate
0
100
52.0
1
1
NIL
HORIZONTAL

SLIDER
391
611
598
644
awareness-rate
awareness-rate
0
100
93.0
1
1
NIL
HORIZONTAL

SLIDER
390
680
606
713
vulnerabilityHistory-rate
vulnerabilityHistory-rate
0
100
29.0
1
1
NIL
HORIZONTAL

SLIDER
659
549
861
582
breachHistory-rate
breachHistory-rate
0
100
21.0
1
1
NIL
HORIZONTAL

SLIDER
659
613
861
646
timeOnBBP-rate
timeOnBBP-rate
0
100
1.0
1
1
NIL
HORIZONTAL

SLIDER
391
483
597
516
speedToAnalyze-rate
speedToAnalyze-rate
0
100
41.0
1
1
NIL
HORIZONTAL

SLIDER
656
339
860
372
platformKnowledge-rate
platformKnowledge-rate
0
100
2.0
1
1
NIL
HORIZONTAL

SLIDER
656
412
860
445
motivation-rate
motivation-rate
0
100
30.0
1
1
NIL
HORIZONTAL

SLIDER
656
483
862
516
accessToResources-rate
accessToResources-rate
0
100
93.0
1
1
NIL
HORIZONTAL

SLIDER
918
338
1139
371
availabilityToResearch-rate
availabilityToResearch-rate
0
100
85.0
1
1
NIL
HORIZONTAL

SLIDER
919
411
1138
444
experienceLevel-rate
experienceLevel-rate
0
100
60.0
1
1
NIL
HORIZONTAL

SLIDER
920
483
1140
516
creativity-rate
creativity-rate
0
100
21.0
1
1
NIL
HORIZONTAL

SLIDER
667
105
839
138
oligopoly-rate
oligopoly-rate
0
100
88.0
1
1
NIL
HORIZONTAL

SLIDER
13
161
187
194
num-of-companies
num-of-companies
0
100
12.0
1
1
NIL
HORIZONTAL

SLIDER
667
682
839
715
num-of-bugs-rate
num-of-bugs-rate
0
100
35.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
