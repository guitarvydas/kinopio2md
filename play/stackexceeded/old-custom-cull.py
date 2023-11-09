import json
import sys

# read file
f = open("fakepipename1", "r")
data = f.read()

# parse file
try:
    obj = json.loads(data)
except:
  sys.exit ("An exception occurred in json.loads ()")

cards = {}

for x in obj['cards']:
    id = x['id']
    card = { 'id' : id, 'name' : x['name'] }
    cards[id] = card

connections = {}
for y in obj['connections']:
    fromCard = y['startCardId']
    toCard = y['endCardId']
    connType = y['connectionTypeId']
    id = y['id']
    connections[id] = { 'id': id, 'from': fromCard, 'to': toCard, 'type': connType }
    
culled = { 'cards' : cards, 'connections': connections}

# Serializing json
json_object = json.dumps(culled, indent=4)
 
print (json_object)

