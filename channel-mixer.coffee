_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect

module.exports = (chs, l, levels, delays) ->

  mixedl = [ l, l ]

  # mixedl = _.map mixedl, (b, i) ->
  #   b = eff.shift b, shift: delays[i]
  #   b = eff.vol   b, factor: levels[i]
  #   b

  # Nt.buildFile 'testL.wav', [ (Nt.convertTo64Bit mixedl[0]) ] 
  # Nt.convertToFloat mixedl[0]

  chs[0] = Nt.mix mixedl[0], chs[0]
  chs[1] = Nt.mix mixedl[1], chs[1]

  # Nt.buildFile 'testM.wav', [ (Nt.convertTo64Bit chs[0]) ] 
  # Nt.convertToFloat chs[0]


  # _.map chs, (ch, chi) ->
  #   for sampleIndex in [ 0 .. mixedl[ chi ].length - 1 ]
  #     sample = mixedl[ chi ][ sampleIndex ]
  #     ch[ sampleIndex ] += sample
  #   ch

  chs