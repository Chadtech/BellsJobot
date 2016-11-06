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

n

_.forEach parts, (part, i) ->
  fileName = './fixed-up-for-iconoclast/part' + i + '.csv'
  fs.writeFileSync fileName, part, 'utf-8'


