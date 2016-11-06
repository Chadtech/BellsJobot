_  = require 'lodash'
fs = require 'fs'

parts = _.map [ 0 .. 8 ], (i) ->
  './score/part' + i + '.csv'

parts = _.map parts, (part) -> 
  fs.readFileSync part, 'utf-8'

parts = _.map parts, (part) ->
  part.split '\n'

parts = _.map parts, (part) ->

  part = _.map part, (line) ->
    line.split ','

  longest = _.reduce part, 
    (longest, line) ->
      if line.length > longest
        line.length
      else
        longest
    part[0].length

  part = _.map part, (line) ->
    while line.length < longest
      line.push ''
    line

  reformattedPart = _.times longest, -> []
  _.forEach part, (line, i) ->
    _.forEach line, (note, j) ->
      if note isnt ''
        note = note.split ' '
        note = [ note[0], 'f', note[1], '0' ]
        note = note.join ''

      reformattedPart[j].push note

  _.map reformattedPart, (line) ->
    line.join ','

  reformattedPart.join '\n'

_.forEach parts, (part, i) ->
  fileName = './fixed-up-for-iconoclast/part' + i + '.csv'
  fs.writeFileSync fileName, part, 'utf-8'


