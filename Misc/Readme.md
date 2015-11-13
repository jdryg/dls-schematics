Miscellaneous/helper components which do not fit in any other category.

## Table of contents
* [Rising Edge Detector](#rising_edge)

## Schematics

### <a name="rising_edge"></a>Rising Edge Detector
[Schematic](Rising%20Edge%20Detector.sch)

This circuit generates a pulse in the output, every time the clock input goes from 0 to 1. The pulse is 3 gate delays wide. Due to the way the simulator works, you will never see a high output. Internally the circuit changes state multiple times during a simulation cycle, and all the changes propagate correctly to the rest of the circuit (i.e. whatever component is connected to this circuit's output). But since the final output from the last NOT gate will always be the opposite of the clock input, the output from the AND gate will always be 0. In the table below you can see the propagation of events for each internal simulation tick (inputs to each gate are shown).

| t | 1st NOT | 2nd NOT | 3rd NOT | AND A | AND B | Output |
|---|---------|---------|---------|-------|-------|--------|
| * | 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 1 | 1 | 1 |
| 2 | 1 | 0 | 1 | 1 | 1 | 1 |
| 3 | 1 | 0 | 1 | 1 | 0 | 0 |

![Rising Edge Detector](images/rising_edge.png "Rising Edge Detector")
