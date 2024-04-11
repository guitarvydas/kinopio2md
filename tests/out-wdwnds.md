## Rethinking Data Structures: A Journey Towards Simplicity and Flexibility

In the realm of software design, the concept of data structures has long been a cornerstone. However, as technology evolves and our understanding deepens, it's becoming increasingly clear that traditional approaches may not always be the most efficient or maintainable. Let's explore how we can rethink data structures to better serve modern programming needs.

### Understanding Use-Cases

Initially, data structures were primarily used for designing and classifying architectural elements. Over time, they evolved into more than just organizational tools – they became a way to fundamentally *think* about the elements of design. Moreover, optimizing memory footprint was a significant driving force, stemming from a bias towards memory re-use dating back to the 1950s. However, this approach, while seemingly efficient, often led to maintenance issues and a lack of understanding due to the lack of locality of reference.

### Addressing Problems

One major problem with traditional data structures is the scattered nature of their implementation throughout codebases. This ad-hoc approach to incorporating data structures often leads to tangled code and makes maintenance a nightmare. Refactoring, while attempting to corral these scattered references, often feels like a game of whack-a-mole, creating new problems in the process.

Another issue arises from the unrestricted access to data alongside primitive control flow constructs, resulting in brittle and hard-to-debug code. Ad-hoc control flow implementations further exacerbate these problems, leading to convoluted code structures that are challenging to reason about.

### Seeking Solutions

To address these challenges, a paradigm shift is necessary. One proposed solution is to eradicate user-defined structures from control-flow programming languages, instead referring only to opaque objects that expose various methods. This move towards Orthogonal Programming Languages aims to separate control flow operations from operands, thereby simplifying code and improving maintainability.

Fundamental operations at the control flow level, such as move and send message, need to be reevaluated and prioritized. Additionally, the use of pattern matching can provide a more structured approach to directing control flow, reducing the reliance on low-level constructs like IF...THEN...ELSE statements.

### Embracing Change

In this new paradigm, attributes must be treated as functions/methods, shielding the caller from the complexities of whether they are calculated or cached. By embracing these changes, we can create codebases that are not only more robust and maintainable but also more flexible and adaptable to evolving needs.

In conclusion, rethinking data structures is not just about finding better ways to organize information; it's about fundamentally changing the way we approach software design. By prioritizing simplicity, flexibility, and maintainability, we can build more resilient systems that stand the test of time.

---

## Rethinking Data Structures: A Path to Simplicity and Efficiency

In the ever-evolving landscape of software development, data structures have long been regarded as foundational elements, essential for organizing and optimizing code. However, as technology progresses and our understanding deepens, it's becoming increasingly evident that traditional approaches to data structures may not always be the most efficient or maintainable. Let's embark on a journey to explore these issues and propose innovative solutions for the future of software design.

### Evolution of Use-Cases

Initially, data structures served pragmatic purposes, aiding in the organization and classification of architectural elements. However, their significance transcended mere organization; they evolved into a framework for conceptualizing design elements. Additionally, the optimization of memory footprint emerged as a driving force, rooted in a bias towards memory re-use from the 1950s. Yet, this optimization often came at the cost of maintainability, as the scattered nature of data references led to a lack of locality of reference. In response, Object-Oriented Programming (OOP) emerged as an attempt to solve this problem by encapsulating data and behavior within objects.

### Addressing Persistent Problems

Despite their usefulness, traditional data structures pose several challenges. One notable issue is the hard-wired knowledge of data structures, which tends to be scattered throughout codebases in an ad-hoc manner. This scattered implementation often leads to tangled code and maintenance headaches. Refactoring attempts to corral these scattered references, but often feels like a game of whack-a-mole, creating new complexities in the process. Furthermore, the unrestricted access to data alongside primitive control flow constructs results in ad-hoc design and brittle, hard-to-debug code.

### Seeking Innovative Solutions

To overcome these challenges, a paradigm shift is imperative. One proposed solution advocates for the eradication of user-defined structures from control-flow programming languages. Instead, opaque objects that expose various methods should be employed, separating control flow operations from operands and enhancing code maintainability. This shift towards Orthogonal Programming Languages represents a departure from the status quo, aiming to simplify code and improve its comprehensibility.

Fundamental operations at the control flow level, such as move and send message, warrant reevaluation and prioritization in this new paradigm. Additionally, the adoption of pattern matching offers a structured approach to directing control flow, mitigating reliance on low-level constructs like IF...THEN...ELSE statements.

### Embracing Change for a Brighter Future

By embracing these changes, we can create codebases that are not only robust and maintainable but also flexible and adaptable to evolving needs. Attributes are to be treated as functions/methods, shielding the caller from the complexities of their implementation details. This shift towards simplicity, flexibility, and maintainability represents a fundamental change in how we approach software design.

In conclusion, rethinking data structures is not merely about organizational concerns; it signifies a fundamental shift in our approach to software design. By prioritizing simplicity and efficiency, we can pave the way for the creation of software systems that are resilient and enduring. It is through this commitment to innovation and adaptation that we can navigate the complexities of modern software development and forge a path towards a brighter, more sustainable future.

---

prompt:
rework the following markdown points into an essay and expand each point: 
# data structures
- use-cases
    - designing and classifying architectural elements
        - evolved into a way to *think* about elements of Design
    - optimizing memory footprint
        - driven by 1950s bias towards memory re-use
            - bad for maintenance and understanding
                - lack of locality of reference
                    - OOP attempted to solve problem
- problems
    - hard-wired knowledge of data structures usually sprayed throughout code in an ad-hoc manner
        - led to concept of refactoring
            - refactoring consists of lassoing references to same data, and, putting them all in the same place
                - whack-a-mole - creates different problems by warping control flow and spraying control flow throughout code in ad-hoc manner (refactoring for data locality-of-reference affects control flow locality-of-reference)
        - caller is allowed to know too much about the structure of datum
    - unrestricted access to data alongside primitive control flow constructs leads to ad-hoc design and brittle, hard-to-debug code
        - ad-hoc control-flow is implemented as: COND + variable(s)
            - COND is BAD for creating structured control flow
                - too loosey-goosey, results in ad-hoc control flow
            - COND is OK for creating conditional values for pure functions
# Conclusions
- eradicate user-defined structures from control-flow programming language, refer only to opaque objects that expose various methods
- Orthogonal Programming Languages
    - split control flow operations from operands
        - GCC does this
            - Cordy's Orthogonal Code Genertor research
            - Fraser-Davidson Peephole technology
        - control flow
            - LIFO-based control flow
                - CALL/RETURN
                    - function-based
                        - Lisp 1.5
                        - ALGOL
                        - etc
                        - FORTRAN
                        - blossomed into FP - Functional Programming
            - FIFO-based control flow
                - message sending
                    - 0D
                        - 0D model uses discrete messages, Containers and Leaves, input and output queues and fan-out, but, not bounded queues
                    - Misty?
                    - FBP
                        - FBP model uses data-flow "streams" between components and processes and operating system assisted suspension (for implementing bounded queues and suspending components when the queues are full)
        - data structuring
            - Rust
            - Python
            - C++
            - etc
        - data manipulation
            - OOP
                - Smalltalk
                - data is private to an object, object exposes methods that can update the data
                - closures
                - etc
- fundamental operations at control flow level
    - move
        - move between mutable cells of RAM
            - only 2 types (at the control flow level)
                - Atom
                - Stack
                    - aka "list"
            - 1. cells
                - assign Atom into cell
                - remove Atom from cell
        - move to arguments for method calls
            - 2. stacks
                - push
                - access top (and top+N?)
                - pop
    - send message
        - should be one of the fundamental operations, but, has been ignored
        - component doesn't send message directly to another component, simply leaves message on its own output queue and lets parent (or operating system) route the message
            - flexibility
            - predictability
                - send operation takes a fixed amount of time and doesn't depend on the receiver
            - requires two types of Components
                - Leaf
                    - code
                        - this is the common notion of a subroutine / function
                - Container
                    - router
                        - Container is like a nano operating system
                            - Implementation of a Container is "code", but the semantics is that of (only) a router
                                - specific algorithm for routing
                                    - fan-out requires atomic delivery of one message to *all* receivers
                                    - implemented and tested in 0D
                            - no need for other operating systems (Linux, Windows, MacOS, etc.)
                                - current operating systems are bloatware - extra, inefficient code added to a system to support the function-based paradigm
    - eq
    - call methods
        - x.y
            - doesn't need parentheses, since attributes and methods are indistinguishable to the caller
        - duck-typing, for now
- control flow code must *not* deal with data structure, but must be restricted to only "call" methods on objects in a very uniform manner
- eradicate IF...THEN...ELSE except locally within a class
    - instead, use pattern matching to direct control flow
        - instead of low-level IF...THEN...ELSE plus variables
        - e.g. delegate control flow to an engine, don't allow developer to tinker with control flow at a syntactic low level
            - Prolog does this
        - pattern-matching is well-understood, but, called "parsing"
            - e.g. syntax-directed pattern matching using parsers (PEG would be a useful tool)
                - OhmJS is my preferred PEG tool
- attribute must be a function/method - caller must not be expected know if it is calculated or cached
