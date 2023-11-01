import json
import sys

# read file
with open('kinopio/globals.json', 'r') as myfile:
    data=myfile.read()

# file = open("/tmp/junk.json", "w")
# file.write(data)
# file.close()

# parse file
obj = json.loads(data)

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

