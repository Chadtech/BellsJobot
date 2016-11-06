_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect
say = require './say.coffee'

module.exports = (seed, vc) ->

  say 'Making timings'

  timings = undefined
  if seed is null
    beatDuration    = 11100
    timings         = [ 0 ]
    _.times (64 * 30),  =>
      timings.push beatDuration
  else
    timings = seed

  alltimings = []

  _.times vc, ->
    anotherTime = _.map timings, (time) ->
      (time + (Math.random() * 200) - 100) // 1
    alltimings.push anotherTime

  output =
    seed:    _.map timings, (t) -> t // 1
    timings: alltimings

  output