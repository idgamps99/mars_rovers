## Mars Rovers Technical Challenge
### Implementation Approach
I decided to design this app as a command-line application

I implemented this solution using a three-class architecture to maintain clear separation of concerns:

1: Plateau Class: Manages the grid coordinates and tracks rover positions

2: Rover Class: Handles individual rover positioning, orientation and movement

3: Interface Class: Processes user input/output and coordinates the simulation

### Design Decisions
Grid tracking: The plateau maintains a hash-based grid that tracks occupied positions to prevent rover collisions

Validation: Each movement is validated before execution to ensure rovers stay within bounds

Error Handling: Comprehensive input validation with specific error messages
