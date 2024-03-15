#!/bin/bash
# jq '.cards { .name, .id }, .connections { .id }' <../kjson/expressivity.json
#jq '.cards[].name' <../kjson/expressivity.json
#jq '{name: .cards[].name, id: .cards[].id}' <../kjson/expressivity.json
#jq '[ {name: .cards[].name, id: .cards[].id} ]' <../kjson/expressivity.json
#jq '{ cards: [ {name: .cards[].name, id: .cards[].id} ]}' <test.json
#jq '{ connections: [ {from: .connections[].startCardId} ] }' <test.json
#jq '{ connections: [ {from: .connections[].startCardId, to: .connections[].endCardId, id: .connections[].id} ] }' <test.json

#jq '{ cards: [ {name: .cards[].name, id: .cards[].id} ] , connections: [ {from: .connections[].startCardId, to: .connections[].endCardId, id: .connections[].id} ] }' <test.json

#jq '{ cards: [ {name: .cards[].name, id: .cards[].id} ]}' <test.json

#jq '.cards[] | { text: .name, id: .id }' <test.json

# text and id for each card as JSON
#jq '.cards[] | { kind: "card", text: .name, id: .id }' <test.json

# connections as JSON
jq '.connections[] | {kind: "connection", from: .startCardId, to: .endCardId, type: .connectionTypeId}' <test.json


# # connections as Prolog
# jq -r '.connections[] | "connection(x\(.startCardId), x\(.endCardId), x\(.connectionTypeId))."' <test.json

# text and id for each card as Prolog
#jq -r '.cards[] | "card(\"\(.name)\", x\(.id))."' <test.json


