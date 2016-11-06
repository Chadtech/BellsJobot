fs      = require 'fs'
_       = require 'lodash'
Nt      = require './noitech.coffee'
gen     = Nt.generate
eff     = Nt.effect
cp      = require 'child_process'
say     = require './say.coffee'

ramp = 60

module.exports = (s, sliceAt, duration, voices, lines, times, timings, voiceCount) ->

  _.times voiceCount, (vi) -> 

    forThisPart = (b) -> 
      if sliceAt 
        b.slice sliceAt, sliceAt + duration
      else b

    melody = forThisPart s[       vi ]
    timing = forThisPart timings[ vi ]
    time   = forThisPart times[   vi ]
    timing = _.map timing, (t) -> t - timing[0]
    time   = _.map time,   (t) -> t - time[0]
    voice  = voices[  vi ] 
    line   = lines[   vi ]

    _.forEach melody, (note, ni) ->

      thisTime = time[ ni ]    
      nextTime = time[ ni + 1 ]

      if note[0] isnt ''

        if voice[ note[0] ] is undefined
          say 'Error. Voice lacks note ' + note[0]
          console.log note, vi, ni

        else

          if ni % 2 is 1

            durationOfNote = sustain: (44100 * 4)
            blockOfSilence = gen.silence durationOfNote
            blockOfLine    = line.slice thisTime - ramp, nextTime
            blockOfSilence = blockOfLine.concat blockOfSilence
            blockOfSilence = eff.fadeOut blockOfSilence, 
              (beginAt: 0, endAt: ramp)
            line = Nt.displace blockOfSilence, line, thisTime - ramp

          n    = eff.vol voice[ note[0] ], factor: (parseInt note[1], 16) / 16
          line = Nt.mix n, line, thisTime

    lines[ vi ] = line

  lines


