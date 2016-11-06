Mix = require './channel-mixer.coffee'
_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect

module.exports = ( channels, l ) ->
  
  #     
  # 6    v0                                   v7
  # 5        v1                          v6
  # 4            v2                 v5
  # 3                v3        v4
  # 2                     
  # 1  
  #      -4  -3  -2  -1    0    1    2    3    4  
  # 
  #                    Listener
  #
  #

  levels = [
    [ 0.9,  0.2  ]
    [ 0.8,  0.3  ]
    [ 0.7,  0.4  ]
    [ 0.6,  0.5  ]
    [ 0.5,  0.6  ]
    [ 0.4,  0.7  ]
    [ 0.3,  0.8  ]
    [ 0.2,  0.9  ]
  ]


  # 0.00777 per meter
  delays = [
    [ 1.12,  1.22 ]
    [ 0.9,   1    ]
    [ 0.7,   0.8  ]
    [ 0.5,   0.6  ]
    [ 0.6,   0.5  ]
    [ 0.8,   0.7  ]
    [ 1,     0.9  ]
    [ 1.22,  1.12 ]
  ]


  _.forEach l, (line, li) ->
    mixedl = [ line, line ]
    level  = levels[ li ]
    delay  = delays[ li ]

    mixedl = _.map [ line, line ], (ch, chi) ->
      ch = eff.shift ch,  shift: delay[ chi ]
      ch = eff.vol   ch, factor: level[ chi ]
      ch


    channels[0] = _.map channels[0], (sample, si) ->
      if mixedl[0].length > si
        sample += mixedl[0][si]
      sample

    channels[1] = _.map channels[1], (sample, si) ->

      if mixedl[1].length > si
        sample += mixedl[1][si]
      sample


  i = channels[0].length - 1
  isEmpty = (ci, si) -> channels[ ci ][ si ] is 0
  i-- while (isEmpty 0, i) and (isEmpty 1, i) and (i > 0)
  channels = _.map channels, (ch) -> ch.slice 0, i
  
  channels





