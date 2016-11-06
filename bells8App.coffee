_        = require 'lodash'
Nt       = require './noitech.coffee'
gen      = Nt.generate
eff      = Nt.effect
cp       = require 'child_process'
fs       = require 'fs'
say      = require './say.coffee'
play     = require './play.coffee'
Channel  = require './channel.coffee'
Convolve = require './convolve.coffee'
stdin    = process.openStdin()


{getFileName, removeFileExtension, getFileExtension} = 
  require './file-name-utilities.coffee'

justPlayed = ''
voiceCount = 8

linesLength = undefined
# lines       = (require './init-lines.coffee') voiceCount
lines       = undefined
timings     = (require './init-timings.coffee') null, voiceCount
timingsSeed =  timings.seed
timings     =  timings.timings
times       = (require './init-times.coffee') timings
voices      =  require './init-voices.coffee'

partLengths = [
  72
  64
  64
  64
  64
  64
  64
  64
  72
]

buildProcess = (sliceAt, duration) => 

  say 'Compiling'

  s = (require './get-score.coffee') voiceCount, partLengths

  if duration
    lines = (require './init-lines.coffee') voiceCount, 
      times[0][ duration ] + (44100 * 6)
  else
    lines = (require './init-lines.coffee') voiceCount, 
      times[0][times[0].length - 1] + (44100 * 6)

  lines = (require './part.coffee') s, 
    sliceAt
    duration
    voices
    lines
    times
    timings
    voiceCount

  Channels = (require './init-channels.coffee') lines[0].length 
  Channels = Channel Channels, lines

  say 'Building from ' + sliceAt 
  Nt.buildFile 'bells8.wav', _.map Channels, (channel) ->
    Nt.convertTo64Bit channel

  say 'Done compiling'


say 'Ready'

console.log 'Bells 5 App Terminal :'
stdin.addListener 'data', (d) ->

  d = d.toString().trim()
  d = d.split ' '

  switch d[0]

    when 'build'

      if d[1] isnt undefined
        buildProcess d[1], d[2]
      else
        buildProcess false


      # if d[1]
      #   if d[1] is 'all'
      #     buildProcess false
      #   else
      #     console.log 'A', d
      #     buildProcess [ (parseInt d[1]), (parseInt d[2]) ]
      #   lines = (require './init-lines.coffee') voiceCount, d[2] * 5000
      #   say 'Lines Reset'
      # else
      #   buildProcess 0

            
    when 'play'
      say 'Playing'

      if d[1]

        f = './' + d[1] + '.wav'
        if fs.existsSync f
          play './' + d[1] + '.wav'
        else
          say 'File does not exist'

        justPlayed = d[1]

      else
        play './bells8.wav'
        say 'Finished playing'


    else
      say 'Does not compute'






