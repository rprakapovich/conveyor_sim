The **conveyor_sim** project is intended for visualisation and validation 
of the efficiency of a linear conveyor with different workstations

[![Watch the video](/data/example.png)](https://www.youtube.com/watch?v=KF4AeIblpEo)

## Overview

![Simulated conveyor](/data/conveyor_legend.png)
Description of the most important parts of the simulated conveyor system

The linear conveyor is described by the following parameters:
- **dt** - Simulation time step, s
- **V** - Conveyor speed, m/s
- **L** - Conveyor length, m
- **S** - Minimum safety distance between units, m
- **W** - Length of unit side, m 
- **Z** - Work zone radius for ich stations on the conveyor, m
- **P** - Unit placement time (period) on moving conveyor, s
- **N** - Number of stations in the first group, pcs
- **D** - Distance between unit centres, m

Each workstation is described in the xlsx-file table and has the following
parameters:
- **Position** - Position along the length of the conveyor, m
- **Picking** - Time for picking of unit from conveyor to the workstation, s
- **Working** - Unit processing time at the workstation, s
- **Placing** - Time for place the unit from the workstation to the conveyor, s
- **Type** - Workstation group number

The next two columns are service fields and do not need to be filled in
(they may be used in the future to simulate a non-zero initial state of
the conveyor):
- **Busy**    - Logical flag to indicate of the workstation busy, bool
- **Process** - Time required to complete the processing of an unit at the
              workstation, s

An example of filling out the rows of the _stations.xlsx_ table located in
the `/data` folder:

| Position | Picking | Working | Placing | Busy | Process | Type |
| -------- | ------- | ------- | ------- | ---- | ------- | ---- |
|    0.7   |    6    |   67    |    8    |   0  |     0   |   1  |
|    1.54  |    6    |   67    |    8    |   0  |     0   |   1  |
|    2.37  |    7    |   52    |    5    |   0  |     0   |   2  |

You can add a maximum of 6 types of workstations to the table. The number
of workstations in each group is almost unlimited.

Once all the necessary parameters have been entered into the table, the
simulation process is started using the **conveyor_sim.m** script. In order
for the m-script to work correctly, you must first activate the 
`Conveyor_sim.prj` file.