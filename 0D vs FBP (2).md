
## 0D vs. FBP (2)

## History

In this chapter, we delve into the historical evolution of the topic at hand, exploring previous iterations and developments in the field.

### Previous Iterations

- **bmfbp**
  - Introduced as "bare metal" FBP in the early 2010s.
- **Visual Frameworks**
  - Emerged in the 1990s and was primarily developed using C++.
- **Arrowgrams**
  - Originated in 2019 and was implemented using Common Lisp and Haskell.
  - Ongoing work can be found at [bmfbp GitHub](https://github.com/bmfbp/bmfbp).
  - Key contributors include Paul Tarvydas, Ken Kan, and Boken Lin.

### odin0d

- Developed by Zac Nowicki.
- Active development spans from 2022 to 2023.
- Introduces "0D for Crystal," possibly under a proprietary license.

### py0d

- Developed between 2021 and 2022.

---

**Chapter Subsection: Seeking Inspiration**

In this subsection, we delve into two fundamental sources of inspiration in the world of technology: electrical engineering principles and Moore's Law. These concepts shed light on the differences between hardware and software development.

**Electrical Engineering (EE):** 
- *Asynchronous Hardware:* EE designs often embrace asynchronous communication by default. Surprisingly, this doesn't lead to significant design difficulties in hardware systems.
- *Robust Hardware:* Hardware designs are meticulously crafted to ensure 0 failures in the field, a stark contrast to software development where field failures are more common.

**Moore's Law:**
- *Hardware's Ever-Expanding Horizons:* Moore's Law, a driving force for hardware, has continuously delivered rapid progress in chip performance and capabilities.
- *Software's Unique Challenges:* In contrast, there is no equivalent to Moore's Law for software, which begs the question: why has software development not witnessed similar exponential growth?

---
## The Pursuit of a Visual Programming Language

In this section, we delve into the core objectives that drove the development of a visual programming language. Initially, the main aim was to simplify the software development process by eliminating both explicit and concealed dependencies. This involved a thorough examination of the root causes and a shift away from the traditional callstack as the primary communication mechanism. Instead, the use of First-In-First-Out (FIFO) structures was adopted, a seemingly simple yet crucial change that was not immediately obvious.

Once all dependencies had been successfully purged, an intriguing outcome emerged: the creation of software diagrams became a natural byproduct of this approach. This was a paradigm shift from the conventional text-based coding methods, and it paved the way for a visual representation of software systems.

Historically, the primary motivation behind this endeavor was the creation of robust software, particularly at the driver level. The intent was to enable the development of drivers at a higher level of abstraction, replacing the ad-hoc C programming that was prevalent.

Furthermore, there was a belief that visual representations, such as diagrams, would yield more robust programs compared to their textual counterparts. This belief was substantiated by the success of various diagram notations, including Harel StateCharts and Electronic Engineering Computer-Aided Design (EE CAD), which demonstrated the effectiveness of visual approaches in various domains. In this context, the utilization of diagrammatic notations, like Drakon, held significant promise in achieving the overarching goal of software robustness.

---

## Compiling Nils Holm's Prolog-Like Code for Scheme into a Prolog Library for JavaScript

In this subsection, we delve into the rationale behind compiling Nils Holm's Prolog-like code originally designed for Scheme into a Prolog library for JavaScript. This decision may appear unconventional at first glance, but it offers some intriguing benefits. Here's a brief summary of the key points:

1. **General-Purpose Languages**: The choice to compile code from one programming language to another is often seen as a watering-down process. It involves finding common ground among different programming paradigms. This section discusses the implications of bridging the gap between Scheme and JavaScript, two versatile general-purpose languages.

2. **A Fresh Perspective**: The decision to compile Nils Holm's code for Prolog-like functionality into JavaScript libraries may seem trivial when viewed from a different perspective. This section explores the unique insights that led to this unconventional approach.

3. **Functional Programming and FEXPRs**: Prolog, along with related relational languages, represents the epitome of functional programming and supports First-Class EXpressions (FEXPRs). We'll delve into how this perspective influenced the conversion process and what it means for JavaScript developers.

4. **A Learning Journey with OhmJS**: The author shares personal insights by discussing this project, which served as their initial foray into using OhmJS. They recount their experience in building a grammar and rewrite code, subsequently rewriting the latter in a .rwr format. A link to a related article provides additional context and resources for readers interested in this journey.

This subsection sets the stage for understanding the unconventional but fascinating journey of compiling Nils Holm's Prolog-like code for Scheme into a Prolog library for JavaScript. It outlines the overarching motivations and the author's personal learning experience, giving readers a context to appreciate the significance of this unique approach.

---

## The Core Activities of a Program

In any software program, there are typically two fundamental activities that underpin its functionality. These activities can be thought of as the program's "breathing cycle." In this chapter, we will explore these two main activities in detail and discuss their significance in the context of software development.

### 2.1 Inhalation: Understanding the Code

The first main activity of a program is akin to taking a breath, as it involves understanding and processing the input data. This process can be further subdivided into several essential subtasks:

1. **Grokking**: This involves gaining a comprehensive understanding of the input data or code. It's the initial step that lays the foundation for further processing.

2. **Parsing**: The parsing phase involves breaking down the input into its constituent parts, such as tokens or syntax elements. This step is crucial for making sense of the input.

3. **Pattern Matching**: In this step, the program attempts to match specific patterns within the input. Traditionally, this has been a complex task, but some programming languages and paradigms, like Nils Holm's Scheme, have made it more accessible and straightforward. It's worth noting that certain languages, such as PROLOG and others, are renowned for their excellence in pattern matching.

Understanding and processing the input data effectively is vital for any program, as it serves as the foundation for the subsequent stages in the program's life cycle.

### 2.2 Exhalation: Transforming the Code

The second primary activity of a program is analogous to exhaling, where the program transforms and produces output, often in the form of code or data. This exhalation phase involves several key subactivities:

1. **Emitting Code**: This step involves generating code or data as output based on the processed input. It is a critical part of the program's functionality.

2. **Formatting Code**: Code readability and structure are essential for maintainability. Formatting code ensures that the generated output is well-organized and follows coding standards.

3. **Transpiling Code**: In some cases, the program may need to transpile or convert code from one programming language to another. This is common in cross-platform development or when migrating codebases.

4. **Rearranging Code**: Rearranging code can involve optimizing it for performance or reordering elements to fit a specific structure or convention.

5. **Inserting Code**: Sometimes, the program may need to insert additional code or data into the output to fulfill specific requirements or dependencies.

This exhalation phase is where the program produces the results it was designed for, making it a crucial component in the software development process.

Understanding and appreciating the interplay between these two main activities is essential for building effective and efficient software systems. In the chapters that follow, we will delve deeper into each of these activities and their intricacies.

---

**Subsection: The Advantages of Using Draw.io for Odin0D**

Draw.io offers several key benefits for editing and visualizing diagrams in the context of Odin0D, making it a suitable choice for this purpose:

1. **Editor-Friendly Approach:**
    - Draw.io provides an intuitive and user-friendly interface for diagram editing, ensuring that editors can easily manipulate and design diagrams without the need for complex compiler code integration.

2. **Flexible Editor Choice:**
    - Odin0D allows users to work with any text editor that can save diagrams in an accessible format. Draw.io supports various export options, including dumbed-down SVG, XML, and graphml, making it compatible with a wide range of editors.

3. **Dumbed-Down SVG:**
    - Draw.io's dumbed-down SVG export simplifies the diagram representation by disregarding over-complicated SVG features. This approach aligns with the concept of "rules" similar to using English in textual programming languages.

4. **Supported Diagram Elements:**
    - Draw.io supports essential diagram elements like rectangles, ellipses, lines, arrows, text, and grouping, ensuring that Odin0D diagrams can be created and edited with ease.

5. **Text Formats for Easy Parsing:**
    - Odin0D encourages using text formats such as XML, which are easily parsed with existing technology. This approach simplifies the process of working with diagrams and facilitates compatibility with various tools.
        - Utilizing tools like PE (Parsing Expression Grammar), including alternatives such as OhmJS, can further enhance the parsing capabilities.

6. **Alternative Diagramming Tools:**
    - While Draw.io is a suitable choice, users can also explore alternative diagramming tools such as yEd and Excalidraw to cater to their specific needs and preferences.

By using Draw.io in Odin0D, editors and users can benefit from a straightforward and versatile approach to diagram creation and editing while ensuring compatibility with a variety of text editors and tools.

---





---

This exploration aims to shed light on the robust nature of hardware design compared to software, highlighting the unique challenges and opportunities in each domain.

---

### History
The chapter delves into the historical background of the subject matter, exploring various iterations such as "bare metal" FBP, Visual Frameworks, Arrowgrams, odin0D, and py0d, along with the individuals involved in these projects.

### Inspiration
This section of the chapter discusses the sources of inspiration that have contributed to the development of the subject matter. It covers topics like the asynchronous nature of integrated circuits, the differences in robustness between hardware and software designs, and questions the absence of a "Moore's Law" equivalent for software.

### Was the main goal to create a visual programming language?
The chapter answers the question of whether the primary objective was to create a visual programming language. It explores the concept of expunging dependencies and its impact on software diagrams, the historical goal of building robust software, and the belief in the superior robustness of diagram-based notations.

### Why compile Nils Holm's Prolog-like code for Scheme into a Prolog library for JavaScript?
This section delves into the reasoning behind the compilation of Nils Holm's Prolog-like code for Scheme into a Prolog library for JavaScript. It touches upon general-purpose languages, the project's origin, and provides a link to further information on the topic.

### 2 main activities of a program
This part of the chapter outlines the two primary activities of a program: "breathing in" (comprehending and pattern matching) and "breathing out" (code generation and transformation). It discusses the challenges and choices in these two phases.

### Why use draw.io for odin0D?
The chapter explains the choice of using draw.io as an editor for odin0D and highlights the principle of keeping the editor simple without compiler code. It also discusses the compatibility of editors that save diagrams in accessible formats and lists specific elements that can be used, such as SVG, XML, and various tools like yEd, Excalidraw, and draw.io.

This subsection provides a comprehensive overview of the historical context, sources of inspiration, and key aspects related to the subject matter explored in the chapter.
## Appendix - ChatGPT Prompt
summarize the following markdown as a subsection for a chapter in a book
## Appendix - Point Form

# History
- previous iterations
    - bmfbp
	    - "bare metal" FBP
	    - 201x
    - Visual Frameworks
	    - 199x
	    - C++
    - Arrowgrams
	    - 2019
	    - Common Lisp
	    - Haskell
	    - https://github.com/bmfbp/bmfbp (WIP)
	    - Paul Tarvydas, Ken Kan
	    - Boken Lin
	- odin0d
		- 2022-2023
		- Zac Nowicki
			- 0D for Crystal
				- proprietary(?)
	- py0d
		- 2021-2022

# inspiration
- EE
    - all ICs are asynchronous by default
        - async default does not cause design difficulties in HW
    - it is possible to design and debug a circuit design, then expect 0 failures in the field
        - in SW, though, there are always failures in the field
            - software designs are not as *robust* as hardware desi
                - why?
- Moore's Law
    - Moore's Law for hardware
    - no Moore's Law for software
        - why?

# Was the main goal to create a visual programming language?
- after doing it, then thinking about it, it turns out to be extremely simple - expunge all dependencies (explicit and hidden)
    - expunging dependencies 
        - understand causes
            - get rid of callstack as the primary communcation mechanism
                - use FIFOs, not LIFOs (easy to do, but, not obvious)
    - once you expunge all dependencies, diagrams of software come "for free"
- historically, the goal was to build robust software, esp. at the *driver* level
    - write drivers at some high level, instead of in ad-hoc C
- it was believed that diagrams or programs would be more robust than textual code for programs
    - example of successful diagram notation: Harel StateCharts
    - example of successful diagram notation: EE CAD
    - other examples
	    - Drakon

# Why compile Nils Holm's Prolog-like code for Scheme into a Prolog library for JavaScript?
- general purpose languages
    - watered-down union of various combinations of programming
- trivial, if you look at it from a different perspective
- PROLOG, et al (Relational Languages) are the epitome of functional programming & FEXPRs
- this was my first project while learning OhmJS
	- I had already built the grammar and the rewrite code
	- rewrote the rewrite code in .rwr format
	- https://guitarvydas.github.io/2020/12/09/OhmInSmallSteps.html

# 2 main activities of a program
- 1. breath in
    - grok
    - parse
    - pattern match
        - traditionally difficult to understand
        - Nils Holm's Scheme code is easy to understand and straight-forward
        - "best" syntax for pattern matching is PROLOG, et al
- 2. breathe out
    - emit code
    - format code
    - transpile code
    - rearrange code
    - insert code

# why use draw.io for odin0D?
- let editor edit
    - don't complicate the editor by inserting compiler code
- choose any editor that saves diagram in an accessible form
    - dumbed-down SVG
        - simply ignore over-complicated uses of SVG
        - Arrowgrams
            - export diagram as SVG
                - draw.io allows exporting as SVG
            - "rules" for what will be parsed
                - akin to "rules" for using English in textual programming languages
        - rect
        - ellipse
        - line, arrow
        - text
        - grouping
    - XML, graphml, etc.
        - text format (e.g. XML) - easily parsed with existing tech
            - PE
                - OhmJS is "better" PEG
        - yEd
        - draw.io
        - Excalidraw

## Appendix - See Also

## See Also

### References

https://guitarvydas.github.io/2021/12/15/References.html

### Blogs
[blog](https://guitarvydas.github.io/)

[obsidian blogs](https://publish.obsidian.md/programmingsimplicity) (see blogs that begin with a date 202x-xx-xx-)
### Videos
[videos - programming simplicity playlist](https://www.youtube.com/@programmingsimplicity2980)
### Books
leanpub'ed (disclaimer: leanpub encourages publishing books before they are finalized - these books are WIPs)
[Programming Simplicity Takeaways, and, Programming Simplicity Broad Brush](https://leanpub.com/u/paul-tarvydas)
### Discord
[Programming Simplicity](https://discord.gg/Jjx62ypR) all welcome, I invite more discussion of these topics, esp. regarding Drawware and 0D
### Twitter
@paul_tarvydas
### Mastodon
(tbd, advice needed re. most appropriate server(s))

<script src="https://utteranc.es/client.js" 
        repo="guitarvydas/guitarvydas.github.io" 
        issue-term="pathname" 
        theme="github-light" 
        crossorigin="anonymous" 
        async> 
</script> 
