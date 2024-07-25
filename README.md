# cclab-np-tools
> Tools for extracting and analyzing np data in cclab.

MATLAB scripts to extract TTL signals from digital channels in NP data. This script extracts pulse start times (as file indices) and their width from digital lines recorded with the neuropixel. 


## Installation

Download this repo and add its folder to your MATLAB path.

The scripts here use this repo: [SpikeGLX_Datafile_Tools](https://github.com/jenniferColonell/SpikeGLX_Datafile_Tools.git). Download it and add it to your MATLAB path as well. This repo provides some functions to read metdata and binary files. There are other packages out there which do this, but this is what I used here.

## Usage example

Make changes to *ana_pulses_np.m*:
- Set *path* and *binFilename* in *ana_pulses_np.m* to a folder and neuropixel *bin* file on your machine.
- Set the vector *dchanIndices* to be the indices of the digital channels. Index 0 corresponds to the NI channel 0.0, index 1 is NI channel 0.1, etc. 

In MATLAB, just run the script

```
>> ana_pulses_np
Sampling rate 10593.400000
File has 23314850 samples, approx 2200.884513 sec
Initial pulses matched onset, w=2657,2657 2657,2657
chanA diff avg 2.0322s +- 0.0034s
chanB diff avg 2.0322s +- 0.0034s
chA-B diff avg 1.0161s +- 0.0027s
```

The script looks in the digital channels in *dchanIndices*, finds the onset and width of each signal. The average of the *time between the pulses* is printed. This was the reason for these scripts - we were verifying the timing of the pulses on two channels. 


## Meta

[Dan Sperka](https://github.com/djsperka) – djsperka@ucdavis.edu

Distributed under the MIT license. See ``LICENSE`` for more information.


