Engineering
- *think* about all details required to make Architecture "just work"
    - kind of like MVP, but the goal is to make the whole Architecture work, not just a part of it
        - the trade-off is "efficiency" - don't worry about "efficiency" yet
- hand off coding to Implementor(s)
    - how do you communicate the intention without micro-managing the details?
        - need a "blueprint" diagram or language
            - "thing" and "list of thing" - no other types needed
            - GC - don't worry about allocation
            - Objects + methods - don't spray knowledge of data structure throughout code
            - data structure is "external" - don't worry about how data is structured, only worry about the existence of the data plus valid operations on it
Implementation
- take "blueprint" from Engineer and code it up and get the code running
    - 1st cut of code
        - in some PL (Python, JS, Rust, etc.)
Production Engineering
- Examine 1st cut of code and blueprints - suggest "more efficient" ways to structure the thing
    - what is the target?
        -  Windows
        - tablet
        - phone
MacOS
- what is the target?
    -  Windows
    - tablet
    - phone
XBOX
- what is the target?
    -  Windows
    - tablet
    - phone
iPhone
- phone
Android phone
- phone
iPad
- tablet
other
- tablet
difference between SWE and SWI
- SWI is touch-typing, without stopping to think
- SWE == thinking about details needed to complete the system
difference between SWE, SWI and SWPE
- SWPE worries about details of types and efficiencies with regard to target(s)
- rewrites blueprints and code to be "more efficient"
    - provenance
    - must be able to automatically map "efficient" code back to the 1st cut, or, to the blueprint
Glossary
- "blueprint" is a drawing / spec more along the lines of the drawings used in construction, not any already-existing SW tech like that of Unreal / Unity
