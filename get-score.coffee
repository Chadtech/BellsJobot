fs = require 'fs'
_  = require 'lodash'

module.exports = (vc, partLengths) ->

  filePather = (partIndex) -> './score/part' + partIndex + '.csv'

  score = [ 0 .. partLengths.length - 1 ]
  _.forEach [
    (part) -> filePather part
    (part) -> fs.readFileSync part, 'utf8'
    (part) -> _.map (part.split '\n'), (line) -> 
      _.map (line.split ','), (note) ->
        _.map (note.split ' '), (q) -> _.trim q
    (part, parti) ->
      if part[0].length < partLengths[ parti ]
        while part[0].length < partLengths[ parti ]
          _.forEach [ 0 .. vc - 1 ], (vi) ->
            part[ vi ].push [ '' ]
      else
        _.forEach [ 0 .. vc - 1 ], (vi) ->
          part[vi] = part[vi].slice 0, partLengths[ parti ]
      part
    ],
    (f) -> score = _.map score, f

  _.reduce score, (a, part) ->
    _.forEach a, (voice, vi) ->
      a[ vi ] = voice.concat part[vi]
    a

