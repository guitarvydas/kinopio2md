This is the test I'm using. 

The URL is in the README.

It's public read only.

Basically there's only several cards on this page. 

The main card has two branches.  Each branch has a tree of sub-branches.

---

The desired result is a markdown file in point-form, indented properly:

---
To get from the Kinopio format to the markdown format I export the Kinopio to JSON, and then run it through a small program program, structured as six components. 

Some of the components are very small but it's nice to get them out of the way and not have to think about them.

Write and forget.

Chip away, make the problem smaller.  The smaller the pieces become, the easier they are to implement.

---

The first component just reads the text file. 

The second component escapes the white space in strings and comments. 

The third component culls the JSON to include only the stuff that's semantically interesting. It removes all the graphical information and all the stuff that I'm not interested in for this particular project.  This step could be replaced by `jq`.

The fourth component transpiles the JSON cards to Prolog rules, creating a factbase.  This component is written in OhmJS+RWR.  I'll describe how that works later.

The fifth component creates markdown from the factbase.  This is written in Prolog.

Prolog does pattern matching and exhaustive searching. It's looking for connections between lumps of text, and deciding what the root of each set of points is.

When it finds a root, it prints out the sub-tree connected to the root.

Finally, we clean everything up by unescaping the white space and outputting the final result.

To run the tool on the exported JSON, we just run `make`.

The red box named "question mark" (`?`) is a probe that shows data as it flows by.

---

The culled JSON is converted to a Prolog factbase.

For this project, I'm only interested in blocks of text and connections between them.

I create `text(...)` facts that include a machine-readable, unique ID, and a string - with spaces escaped.  So, every piece of text is represented as a string with an ID.

I create `connection(...)` facts that tie the text blocks together.  I drew the connections in Kinopio, making connections between Kinopio cards in the usual Kinopio fashion.  This format is reduced to Prolog `connection(...)` facts that contain 3 IDs - the source text, the target text and a unique ID for the Kinopio connection type.  At this point, I simply ignore the Kinopio connection type information and assume that every connection is a markdown indentation.  Later, if I have time, I might try to recognize some connections as footnotes, others as comments and so on, but, not now. I'm only interested in source IDs and target IDs in connection facts at this time.

The step labelled "Transpile Cards to PROLOG" writes these facts out to a local file called `content.pl`.

---

The 5th step runs the PROLOG program which figures out the translation from facts to markdown.

The program itself is called 'md.pl' and can be found in the main kinopio2md directory.

The program first reads in the factbase using the command `consult(md).` Then it runs a number of very simple pattern matches against the factbase. The search is recursive and finds ALL of the possible matches as specified by my program.  This is what PROLOG does well - exhaustive search - using very little syntax and very few lines of code. You can do this by writing loops within loops using some other language, say JavaScript, but, PROLOG makes it easier to write and to get it right without missing any edge cases.

The gotcha with PROLOG is that it uses backtracking, which used to be considered insanely inefficient in the 1950s, but, on today's hardware it runs fast enough.  To my eyes, it looks like it finishes instantly.  I don't care if it took 100 microseconds instead of 100 nanoseconds.  I can't tell the difference.  I guess I would care if I sold this to one billion people who didn't have computers as good as development machines I've used since about the year 2000.

The other gotcha with PROLOG is that you need to change the way you think.  You can't write code in the usual imperative manner. You write code that says what to match for, and the PROLOG engine takes care of finding the matches for you.  You can't tell it how to do the matching.  At first, I was puzzled, but, now I can't imagine doing pattern matching any other way.

The important component of the PROLOG program is the for all statement 

which tells the PROLOG engine to find everything that matches the `is_root(...)` pattern and then run the `print_root(...)` rule on each of those matches.

`is_root(ID)` is nearly trivial. It says that a root is any piece of text that is not a child. 

Let's take that apart.  Start at the `is_root` rule. It has only 2 lines of code in it. All of the lines of code have to be true for the rule to succeed. When the rule succeeds, it sets the variable `ID` to the ID of some text item.

The pattern is
1. The ID must be a text id.
2. The ID must not match `is_child(...)`.

That's pretty concise!

Now, let's looks at the `is_child(...)` rule. It is also ridiculously concise. It says that an ID is considered to be a child if there is any `connection(...)` fact that includes the ID as a target.

PROLOG finds one match at a time, then backtracks.  The programmer needs to ask PROLOG for each match. At the command line, the programmer uses the semi-colon key ';'. In code, the programmers uses the `forall` rule.

The end. That's the code for figuring out which IDs are roots.  3 lines of code.

Next, let's look at the rule for `print_root(...)`.

You'll see 2 contiguous rules called `print_root(...).`.  That's already different from the way we're used to writing code.

One version of the rule specifies how to match a `print_root(...)`, and, the other version specifies a different way.

The PROLOG engine just tries every rule over and over again until it can't find a match.

In other programming languages, like JavaScript and Rust, etc., we would use loops within loops and `or` expressions.  And, we'd probably miss some edge-case along the way or inadvertantly insert bugs into our code.

In this case, our first `print_root` rule says to print the node and then to print the tree for each child.  The second `print_root` rule handles the edge case where a root doesn't have any children. If there aren't any connections with the root's ID as the source, then the root doesn't have any children and we just print the node and finish.

The rule `print_node` just punts its work to the `print_text` rule.

`Print_tree` prints the text at each level preceded by a dash (`-`).  `Print_node` and `print_tree` track the indentation and print 4 spaces for each level of indentation - the standard for markdown indentation.  The root has an indentation level of zero (`0`).  Each successive call to `print_node increments the level.

The net result is that the code prints each node at a given level of indentation, along with all of its children at the next level of indentation.  This happens recursively, so the children of the children are indented beneath each child.  The recursion happens in a depth-first manner, so that a fully indented sub-tree is printed in its entirety before any any other sub-tree is printed.

---

## Future - Moving Forward
- The Prolog code was grown incrementally. It could probably be rewritten and refined. 
- I want to see if `jq` can be used to replace some of the steps.
- I want to try bigger and bigger Kinopio spaces.

---
