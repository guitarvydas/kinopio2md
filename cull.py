import json

# read file
with open('test.json', 'r') as myfile:
    data=myfile.read()

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
    
# print ()
# for c in cards:
#     print (cards[c])

# print ()
# for j in connections:
#     print (connections[j])

# print ()
culled = { 'cards' : cards, 'connections': connections}
# print (culled)

# Serializing json
json_object = json.dumps(culled, indent=4)
 
# Writing to sample.json
with open("out.json", "w") as outfile:
    outfile.write(json_object)


