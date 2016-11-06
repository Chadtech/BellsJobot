Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect
say = require './say.coffee'


octavesOfBellG = []
thisOctave     = []

say 'Loading Bells'

for bellIndex in [0 .. 44 ]

  bellNumber = bellIndex % 5
  bellNumber += ''
  bellNumber = (bellIndex // 5) + bellNumber

  filePath = './bellG/bellG' + bellNumber
  filePath += '.wav'

  thisBellSound = Nt.open filePath
  thisBellSound = Nt.convertToFloat thisBellSound[0]
  thisBellSound = eff.vol thisBellSound, factor: 0.25
  
  thisOctave.push thisBellSound

  if (bellIndex % 5) is 4
    octavesOfBellG.push thisOctave

    thisOctave = []


octavesOfBellH = []
thisOctave     = []

for bellIndex in [0 .. 44 ]

  bellNumber = bellIndex % 5
  bellNumber += ''
  bellNumber = (bellIndex // 5) + bellNumber

  filePath = './BellH/BellH' + bellNumber
  filePath += '.wav'

  thisBellSound = Nt.open filePath
  thisBellSound = Nt.convertToFloat thisBellSound[0]
  thisBellSound = eff.vol thisBellSound, factor: 0.25
  
  thisOctave.push thisBellSound

  if (bellIndex % 5) is 4
    octavesOfBellH.push thisOctave

    thisOctave = []


voice0 =
  '12': octavesOfBellG[2][2]
  '13': octavesOfBellG[2][3]
  '14': octavesOfBellG[2][4]
  '20': octavesOfBellG[3][0]
  '21': octavesOfBellG[3][1]
  '22': octavesOfBellG[3][2]
  '23': octavesOfBellG[3][3]
  '24': octavesOfBellG[3][4]

voice1 =
  '12': octavesOfBellG[2][2]
  '13': octavesOfBellG[2][3]
  '14': octavesOfBellG[2][4]
  '20': octavesOfBellG[3][0]
  '21': octavesOfBellG[3][1]
  '22': octavesOfBellG[3][2]
  '23': octavesOfBellG[3][3]
  '24': octavesOfBellG[3][4]


voice2 =
  '22': octavesOfBellG[3][2]
  '23': octavesOfBellG[3][3]
  '24': octavesOfBellG[3][4]
  '30': octavesOfBellG[4][0]
  '31': octavesOfBellG[4][1]
  '32': octavesOfBellG[4][2]
  '33': octavesOfBellG[4][3]
  '34': octavesOfBellG[4][4]

voice3 =
  '22': octavesOfBellG[3][2]
  '23': octavesOfBellG[3][3]
  '24': octavesOfBellG[3][4]
  '30': octavesOfBellG[4][0]
  '31': octavesOfBellG[4][1]
  '32': octavesOfBellG[4][2]
  '33': octavesOfBellG[4][3]
  '34': octavesOfBellG[4][4]


voice4 =
  '32': octavesOfBellH[4][2]
  '33': octavesOfBellH[4][3]
  '34': octavesOfBellH[4][4]
  '40': octavesOfBellH[5][0]
  '41': octavesOfBellH[5][1]
  '42': octavesOfBellH[5][2]
  '43': octavesOfBellH[5][3]
  '44': octavesOfBellH[5][4]

voice5 =
  '32': octavesOfBellH[4][2]
  '33': octavesOfBellH[4][3]
  '34': octavesOfBellH[4][4]
  '40': octavesOfBellH[5][0]
  '41': octavesOfBellH[5][1]
  '42': octavesOfBellH[5][2]
  '43': octavesOfBellH[5][3]
  '44': octavesOfBellH[5][4]


voice6 =
  '42': octavesOfBellH[5][2]
  '43': octavesOfBellH[5][3]
  '44': octavesOfBellH[5][4]
  '50': octavesOfBellH[6][0]
  '51': octavesOfBellH[6][1]
  '52': octavesOfBellH[6][2]
  '53': octavesOfBellH[6][3]
  '54': octavesOfBellH[6][4]

voice7 =
  '42': octavesOfBellH[5][2]
  '43': octavesOfBellH[5][3]
  '44': octavesOfBellH[5][4]
  '50': octavesOfBellH[6][0]
  '51': octavesOfBellH[6][1]
  '52': octavesOfBellH[6][2]
  '53': octavesOfBellH[6][3]
  '54': octavesOfBellH[6][4]



voices =  [
  voice0
  voice1
  voice2
  voice3
  voice4
  voice5
  voice6
  voice7
]

module.exports = voices