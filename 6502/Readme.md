A 6502 compatible CPU (should be cycle accurate) and C64 Kernal/BASIC ROM.

There are 2 versions of this circuit. One written in Javascript for DLS v0.6.x, and one written in Lua 5.1 for DLS v0.7 and up. Choose the correct one based on your current DLS version. 

#### 0.6.x version
Configured to run at 3.78kHz (clock multiplier = 63). You can enable instruction tracing by editing the 6502 component and changing the ENABLE_LOGGING variable to true.

Boot time is approximately 30 sec from reset to the READY prompt. No keyboard support at the moment as this requires additions to the simulator.

#### 0.7 version
Configured to run at 15.3kHz (clock multiplier = 255). Haven't implemented instruction tracing in this one.

Boot time is approximately 8 sec from reset to the READY prompt. Includes a testbench which compares the execution speed of the initialization code for different clock multipliers.

## Schematic
### <a name="6502"></a>6502
[Schematic (v0.6.1)](6502_v0.6.1.sch) [Schematic (v0.7.0)](6502_v0.7.0.sch)
![6502](images/6502.png "6502")
