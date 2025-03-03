// Arrays de comandos y propiedades transformados
final List<Map<String, String>> legendCommands = [
  {'command': 'f', 'description': 'forward'},
  {'command': 'b', 'description': 'backwards'},
  {'command': 'd', 'description': 'down'},
  {'command': 'u', 'description': 'up'},
  {'command': 'df', 'description': 'down and forward'},
  {'command': 'db', 'description': 'down and back'},
  {'command': 'uf', 'description': 'up and forward'},
  {'command': 'ub', 'description': 'up and back'},
  {'command': 'qcf', 'description': 'quarter circle forward'},
  {'command': 'qcb', 'description': 'quarter circle back'},
  {'command': 'hcf', 'description': 'half circle forward'},
  {'command': 'hcb', 'description': 'half circle back'},
  {'command': '1', 'description': 'left punch'},
  {'command': '2', 'description': 'right punch'},
  {'command': '3', 'description': 'left kick'},
  {'command': '4', 'description': 'right kick'},
  {'command': '*', 'description': 'hold'},
  {'command': '~', 'description': 'slide input'},
  {'command': '+', 'description': 'press buttons at the same time'},
  {'command': ',', 'description': 'followed by'},
];

final List<Map<String, String>> legendProperties = [
  {'property': 'c', 'description': 'forces crouch'},
  {
    'property': 'g',
    'description':
    'can guard (use this for moves which are +10 or more where you can still block)'
  },
  {'property': 'js', 'description': 'jump state'},
  {'property': 'cs', 'description': 'crouch state'},
  {
    'property': 'a',
    'description':
    'aerial state (legacy moves causing float on opponents not holding back)'
  },
  {'property': 'pc', 'description': 'power crush'},
  {'property': 'wc', 'description': 'wall crush'},
  {'property': 'FC', 'description': 'full crouch'},
  {'property': 'hom', 'description': 'Homing'},
  {'property': 'T!', 'description': 'Tornado spin (screw)'},
  {'property': 'RA', 'description': 'Rage art'},
  {'property': 'KND', 'description': 'Knock down'},
  {'property': 'Launch', 'description': 'Launch'},
  {'property': 'act', 'description': 'Active frames'},
  {'property': 'HT', 'description': 'Heat state'},
  {'property': 'HS', 'description': 'Heat smash'},
  {'property': 'HB', 'description': 'Heat Burst'},
];