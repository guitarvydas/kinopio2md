# back-pressure
- FBP - yes
    - requires operating system
- 0D - no
    - back-pressure is just ACK/NAK-like protocol (e.g. networking)
        - doesn't require operating system
            - Architect / programmer must implement back-pressure explicitly (straight-forward

# input queues
- FBP - one queue per Port
- 0D - one queue per Component
    - Component must react to *every* input (Component has no choice)
        - if Component wishes to deal with the input later, it must explicitly implement bufferin

# concurrent components
- FBP - yes
    - requires operating system processes
- 0D - yes
    - simple implementation, doesn't need operating system
        - a *process* is just a *closure*, anyway

# fan-out
- FBP - forbidden
- 0D - supported, despite technical difficulties
    - fan-out is necessary for supporting *abstraction*
        - fan-out is a UX issue more than a technical issue

