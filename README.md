convert Kinopio mind-map to markdown

0. begin with kinopio drawing "test" which contains cards and connections between cards
0. export to "test.json"

1. cull the json file, leaving only semantic information
   - cards
	 - id
	 - name
   - connections
	 - id
	 - from (card id)
	 - to   (card id)
	 - connectionType (used to determine whether the connection is indentation or footnote)
