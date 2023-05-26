globals [
  %vulnerable
  %overallSatisfaction-Researchers
  %overallSatisfaction-Companies
  vulnerability-data
  ;;Ranges to be used with companies
  ;payout-range-list

  ;;Ranges to be used with companies
  payoutCapability-list
  breach-history-list
  awareness-list
  time-on-bbp-list
  vulnerability-history-list
  num-of-bugs-list
  validity-period-list

  complexity-list



  ;;Ranges to be used with researchers
  ability-to-findBugs-list
  ;;Ability based on hackthebox ranks Noob >= 0%,Script Kiddie > 5%, Hacker > 20%, Pro Hacker > 45%,Elite Hacker > 70%,Guru > 90% and Omniscient = 100%
  knowledge-level-list
  speed-to-analyze-list
  platform-knowledge-list
  honesty-list ; measure of honesty and dishonesty of
  motivation-list ;pride,vanity,brandInterest,
  access-to-resources-list
  availability-to-research-list
  experience-level-list
  creativity-list


  reliability-list
  ;payoutCapability-list
  responsetime-list
  oligopoly-list



] ;;global variable vulnerable created

patches-own [ ; the entire patch space is considered a bug bounty program
 reliability
 oligopoly
 ;payoutCapability
 responsetime
 ;validity-period
 verification-process
 verification-process-time
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
  ;payoutRange;
  payoutCapability
  awareness;
  vulnerabilityHistory ;vulnerabilities found during
  breachHistory;
  timeOnBBP;
  num-of-bugs;
  service-satifaction
  validity-period
]


securityResearchers-own [
  abilityToFindBugs
  knowledgeLevel
  speedToAnalyze
  platformKnowledge
  honesty ; measure of honesty and dishonesty of
  motivation ;pride,vanity,brandInterest,
  accessToResources
  availabilityToResearch
  experienceLevel
  creativity
  memory;; to develop module for this, may be not needed for now
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;             Create the environment

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to setup
  clear-all

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
  implement-randomizedValues-on-breeds
  ask companies [
    set label (word "CID: " who " - Bugs: " num-of-bugs)
  ]

  reset-ticks
end


to implement-randomizedValues-on-breeds
;  set reliability-list n-values 20 [random 100]
;  set payoutCapability-list n-values 20 [random 100]
;  set responsetime-list n-values 20 [random 100]
;  set oligopoly-list n-values 20 [random 100]
;

  ;; set company breed properties
  set payoutCapability-list (list 10000 20000 30000 50000 50000 100000 200000 250000 300000 500000)
  ;set payout-range-list n-values 20 [random 100]
  set breach-history-list n-values 20 [random 100]
  set awareness-list n-values 20 [random 100]
  set time-on-bbp-list n-values 20 [random 100]
  set vulnerability-history-list n-values 20 [random 100]
  set num-of-bugs-list n-values 8 [random 8]
  set validity-period-list  (list "30 days" "90 days" "180 days" "360 days" "Undefined")
  ;set validity-period-value one-of ["30 days" "90 days" "180 days" "360 days" "Undefined"]
  ;;look at how to randomize the n-values or if there's any significance to it





  ;; set security researcher breed properties
  ;;set ability-to-findBugs-list n-values 20 [random 100]
  ;;set ability-to-findBugs-list ["Noob" "Script Kiddie" "Hacker" "Pro Hacker" "Elite Hacker" "Guru" "Omniscient"] ;; Find a way to translate these to numbers
  set ability-to-findBugs-list ["Noob" "Pro Hacker" "Guru" "Omniscient"] ;; Find a way to translate these to numbers
  set knowledge-level-list n-values 20 [random 100]
  set speed-to-analyze-list n-values 20 [random 100]
  set platform-knowledge-list n-values 20 [random 100]
  set honesty-list [true false];;n-values 20 [random 100] ; measure of honesty and dishonesty of, for now let's give it a range
  set motivation-list  n-values 20 [random 100];pride,vanity,brandInterest,
  set access-to-resources-list n-values 20 [random 100]
  set availability-to-research-list n-values 20 [random 100]
  set experience-level-list n-values 20 [random 100]
  set creativity-list n-values 20 [random 100]


  let reliability-value random 10
  ;let payoutCapability-value one-of [10000 20000 30000 50000 50000 100000 200000 250000 300000 500000]
  let responsetime-value random-float 10
  let oligopoly-value one-of ["Low" "Medium" "High"]
  ;let validity-period-value one-of ["30 days" "90 days" "180 days" "360 days" "Undefined"]
  let verification-process-value one-of [ "Automated" "Manual"]
  let verification-process-time-value one-of ["Fast" "Lengthy" ]

  ask patches [;Improve this at a later stage to simulate multiple bug bounty programs
    set reliability reliability-value
    ;set payoutCapability payoutCapability-value
    set responsetime responsetime-value
    set oligopoly oligopoly-value
    ;set validity-period validity-period-value
    set verification-process verification-process-value
    set verification-process-time verification-process-time-value

  ;show (word "Reliability: " reliability)
  ;show (word "Payout Capability: " payoutCapability)
  ;show (word "Response Time: " responsetime)
  ;show (word "Oligopoly: " oligopoly)
  ]


  ask companies [
    ;set for this case we will have to provide a list of values for each company. investigate how to make it more randomized;

    ;set payoutRange one-of payout-range-list;
    set payoutCapability one-of payoutCapability-list
    ;show payoutRange
    set breachHistory one-of breach-history-list;
    set awareness one-of awareness-list;
    set timeOnBBP one-of time-on-bbp-list;
    set vulnerabilityHistory one-of vulnerability-history-list;vulnerabilities found during
    set num-of-bugs one-of num-of-bugs-list
    set validity-period one-of validity-period-list

   ]
   ;figure out a way to randomize company links as well, should be dynamically linked to the number of companies placed in the environment.
   ;;let num-links random count companies  ;
   ;show num-links
   ;ask n-of num-links companies [
  ;ask n-of 2 companies [
   ; create-links-with other n-of 2 companies with [self != myself]
  ;] hold off on the links part of the bug bounty problem


  ;; set securityResearchers breed properties
  ask securityResearchers [
    ;set breed-property value;
    set abilityToFindBugs one-of ability-to-findBugs-list;
    ;show abilityToFindBugs
    set knowledgeLevel one-of knowledge-level-list
    set speedToAnalyze one-of speed-to-analyze-list
    set platformKnowledge one-of platform-knowledge-list;
    set honesty one-of honesty-list
    set motivation one-of motivation-list
    set accessToResources one-of access-to-resources-list
    set availabilityToResearch one-of availability-to-research-list
    set experienceLevel one-of experience-level-list
    set creativity one-of creativity-list
    ;show creativity
  ]
end

to go
  tick ;; time system to advance by 1 day
  ;;ask turtles ;; ask the turtles to move around , move in diferent directions randomly

  ask securityResearchers [
    ;show abilityToFindBugs
    ;let researcher-ability abilityToFindBugs
    ;let researcher-honesty honesty
    setxy random-xcor random-ycor
    look-for-bugs honesty abilityToFindBugs motivation
  ]
  calc-vulnerable-percentage
  if %vulnerable = 0 [stop] ;; if all are safe then end the simulation
end


to calc-vulnerable-percentage
let total-companies count companies
;show (word "Total Companies: " total-companies)

let total-companies-with-bugs count companies with [num-of-bugs > 0]
;show (word "Total Companies with bugs: " total-companies-with-bugs)

let vulnerability-percentage 0
if total-companies > 0 [
  set vulnerability-percentage (total-companies-with-bugs / total-companies) * 100
]

;show (word "% Vulnerable: " vulnerability-percentage);; defining the infected variable.

 set %vulnerable vulnerability-percentage

end

to look-for-bugs [researcher-honesty researcher-ability researcher-motivation]
;show researcher-honesty
;let abc one-of neighbors
;if abc != nobody [
;  show abc
;]

let xyz one-of companies-here

  if xyz != nobody [; If company has been found to be in the same patch as a researcher. $$$gateway to heaven
    ;show xyz


    let bbp-reliability [reliability] of xyz
    let bbp-oligopoly [oligopoly] of xyz
    let bbp-responsetime [responsetime] of xyz
    ;let patch-validity-period [validity-period] of xyz
    let bbp-verification-process [verification-process] of xyz
    let bbp-verification-process-time [verification-process-time] of xyz

;    show patch-reliability
;    show patch-oligopoly
;    show patch-responsetime
;    show patch-verification-process
;    show patch-verification-process-time
;    Uncomment above to confirm details of the patches and the researcher is on.

    ;;;;;; Checks for Security Researchers start here.Beginning with researcher honesty
    ifelse bbp-reliability > 5 [;based on this research https://www.emerald.com/insight/content/doi/10.1108/IJCHM-06-2018-0532/full/html#sec011 Overall, 50-68 per cent of customers gave the highest rating, with Foodora having the least satisfied customers and UberEats having the most satisfied customers
      if researcher-honesty[;; only work on vulnerabilities if a researcher is honest , think of the else condition later on if need be to introduce black hat operators
      ;show researcher-honesty

      set motivation motivation + 1
      if researcher-ability = "Pro Hacker" or researcher-ability = "Omnicient" [
        ;show researcher-ability
        ask xyz [
          ;show (word "Before: " num-of-bugs)
          if num-of-bugs > 0 [ ;;Begin to work on each property

          set num-of-bugs num-of-bugs - 1
          ;show (word "After: " num-of-bugs)
          set label (word "CID: " who " - Bugs: " num-of-bugs)]
        ];may be add functionality to increase bugs after some time.
      ]
     ]
    ]
    [; when Reliability is less than 5 ; also add a way you can increase this reliability
        if researcher-honesty[;; only work on vulnerabilities if a researcher is honest , think of the else condition later on if need be to introduce black hat operators
      ;show researcher-honesty
      set motivation motivation - 1
      if researcher-ability = "Pro Hacker" or researcher-ability = "Omnicient" [
        ;show researcher-ability
        ask xyz [
          ;show (word "Before: " num-of-bugs)
          if num-of-bugs > 0 [ ;;Begin to work on each property
          set num-of-bugs num-of-bugs - 1
          ;show (word "After: " num-of-bugs)
          set label (word "CID: " who " - Bugs: " num-of-bugs)]
        ];may be add functionality to increase bugs after some time.
      ]
     ]

    ]

  ]

;  ask companies [
;    let researchers-here securityResearchers-here
;    if any? researchers-here [
;      let target-company self
;      ask researchers-here [
;        ask target-company [
;          set num-of-bugs num-of-bugs - 1
;        ]
;      ]
;    ]
;  ]

;  let target-company one-of companies;;
;  let researcher-on-company securityResearchers-on target-company
;  if any? researcher-on-company
;  [
;    ask researchers-on-company [
;      ask target-company [
;        set num-of-bugs num-of-bugs - 1
;      ]
;    ]
;  ]

;  if [num-of-bugs] of target-company  > 0 [
;    ask target-company [
;      set num-of-bugs num-of-bugs - 1 ;;
;    ]
;  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
870
10
1592
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
2
22
150
55
Setup environment
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
163
22
246
55
simulate
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
80.0
1
1
NIL
HORIZONTAL

MONITOR
515
280
676
325
% of Vulnerable Systems
%vulnerable
17
1
11

MONITOR
513
340
679
385
Days taken
ticks
0
1
11

SLIDER
13
161
187
194
num-of-companies
num-of-companies
0
100
14.0
1
1
NIL
HORIZONTAL

PLOT
378
88
811
238
Overall Vulnerabilities in the BBP
Days
Vulnerabilites Percentage
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -8053223 true "" "plot %vulnerable"

MONITOR
378
431
460
476
Companies
count companies
17
1
11

MONITOR
382
568
471
613
Researchers
Count securityResearchers
17
1
11

@#$#@#$#@
##ChangeLog 
V1.1
1. Added a new breed - bugs, to simulate security researchers hunting for bugs 
	this will also help the breed
--- this is still not working accordingly 

2. Having troubles reflecting the changes on different breeds. One breed can't change the breed of another 

V1.2
===
Fixed above issues 
1. Now working on incorporating the different properties of agents in the bbp
2. Function for showing vulnerable systems working 
3. Figure out other visualization data. 
4. Figure if we need to simulate that the company initially gets vulnerability or simulate if a companies' vulnerability is gradually discovered and they gradually decrease. 
5. Added condition for researcher to only solve vulnerability if he/she is honest 
6. Might have to assume all  companies join at the same time, to eliminate complexity with introducing new companies. But this can be fixed in the near future 
7. Access to resources for researchers will give a researcher a chance to increase skills hence increasing there rank to something else 
8. Rethink the whole idea of time. May be ticks can now represent seconds/minutes instead of days. Since simulation seems to take way longer than usual. 
9. 



V1.3
====
1. Focus should be on the bug bounty programs, so remodell all agents to work with the the BBP(patches)
2. All patches have properties taht are set to randomized values. 
3. These properties are replicated across all patches to simulate one bug bounty. 
4. Added 2 new properties on bug bounty programs 
	validity-period
	verification-process
	verification-process-time
5. Moved payout capability to the companies instead of the BBP 
6. Vulnerabiility and breach history might not be necessary for now. 
7. Research how each of the properties of the BBP affects other agents then implement. 

V1.4
====
1. Added service satisfaction property to companies , to be use in conjuction with 
2. Added motivation to researchers 
3. Removed most bugs property as it is irrelevant for our scenario for now 
4. Try and make more scenarios geered towards bbp properties: 
- reliability
- oligopoly
- responsetime
- verification-process
- verification-process-time
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