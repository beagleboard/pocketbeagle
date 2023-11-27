# ADC tool

## Overview
This is an tool to read all ADC channels of PocketBeagle board. It makes the process of testing PocketBeagle board ADCs easier.
This tool has three different operational modes:
 
### Mode 1: single-shot
In this mode, a single read of counts and voltages of all ADC channels of PocketBeagle board will be done.
Usage: ./adc_tool.sh single
 
### Mode 2: countinuous
In this mode, all ADC channels of PocketBeagle board are continuosly read, and the time between the reads can be set in command line.
Usage: ./adc_tool.sh cont TIME, where TIME stands for the time (seconds) between two consecutive reads
 
### Mode 3: custom
In this mode, all ADC channels of PocketBeagle board are read as informed in command line, where number of reads and time between the reads are set in command line.
Usage: ./adc_tool.sh custom NUM TIME
where:
* NUM stands for how many reads will be done
* TIME stands for the time (seconds) between two consecutive reads.
