#!/bin/bash

#################################################################
# This is an tool to read all ADC channels of PocketBeagle board.
# It makes the process of testing PocketBeagle board ADCs easier.
#
# Author: Pedro Bertoleti
################################################################

# Function to read counts & voltage from all PocketBoard ADC channels
read_all_adc_channels()
{
    # Read ADC channels counts
    COUNTS_CH0_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage0_raw)
    COUNTS_CH1_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage1_raw)
    COUNTS_CH2_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage2_raw)
    COUNTS_CH3_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage3_raw)
    COUNTS_CH4_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage4_raw)
    COUNTS_CH5_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage5_raw)
    COUNTS_CH6_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage6_raw)
    COUNTS_CH7_ADC=$(cat /sys/bus/platform/drivers/TI-am335x-adc/TI-am335x-adc.0.auto/iio:device0/in_voltage7_raw)

    # Do zero-left padding (for better visualization)
    COUNTS_CH0_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH0_ADC")
    COUNTS_CH1_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH1_ADC")
    COUNTS_CH2_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH2_ADC")
    COUNTS_CH3_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH3_ADC")
    COUNTS_CH4_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH4_ADC")
    COUNTS_CH5_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH5_ADC")
    COUNTS_CH6_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH6_ADC")
    COUNTS_CH7_ADC_LEFT_PAD=$(printf "%04d" "$COUNTS_CH7_ADC")

    # Calculate all ADC channels voltages
    MAX_VOLTAGE_ADC=1.8
    MAX_COUNTS_ADC=4095  # 12-bit ADC
    VOLTAGE_CH0_ADC=$(echo "scale=3; $COUNTS_CH0_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)
    VOLTAGE_CH1_ADC=$(echo "scale=3; $COUNTS_CH1_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)
    VOLTAGE_CH2_ADC=$(echo "scale=3; $COUNTS_CH2_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)
    VOLTAGE_CH3_ADC=$(echo "scale=3; $COUNTS_CH3_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)
    VOLTAGE_CH4_ADC=$(echo "scale=3; $COUNTS_CH4_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)
    VOLTAGE_CH5_ADC=$(echo "scale=3; $COUNTS_CH5_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)
    VOLTAGE_CH6_ADC=$(echo "scale=3; $COUNTS_CH6_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)
    VOLTAGE_CH7_ADC=$(echo "scale=3; $COUNTS_CH7_ADC * $MAX_VOLTAGE_ADC / $MAX_COUNTS_ADC" | bc)

    echo "CH0:    Counts = $COUNTS_CH0_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH0_ADC V"
    echo "CH1:    Counts = $COUNTS_CH1_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH1_ADC V"
    echo "CH2:    Counts = $COUNTS_CH2_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH2_ADC V"
    echo "CH3:    Counts = $COUNTS_CH3_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH3_ADC V"
    echo "CH4:    Counts = $COUNTS_CH4_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH4_ADC V"
    echo "CH5:    Counts = $COUNTS_CH5_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH5_ADC V"
    echo "CH6:    Counts = $COUNTS_CH6_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH6_ADC V"
    echo "CH7:    Counts = $COUNTS_CH7_ADC_LEFT_PAD  |  Voltage:  $VOLTAGE_CH7_ADC V"
}


##### MAIN SCRIPT #####
READ_TYPE=$1
LIST_READ_TYPES=("single" "cont" "custom" "help")

case "${LIST_READ_TYPES[@]}" in
    *"$READ_TYPE"*)
        echo "Read type: $READ_TYPE"
        ;;
    *)
        echo "Invalid read type. Exiting..."
        ;;
esac

# If script reaches here, the read type is valid.
# Read type: help
if [ "$READ_TYPE" = "help" ]; then
    echo "Help - ADC tool for PocketBeagle Board"
    echo " "
    echo "Overview:"
    echo "This is an tool to read all ADC channels of PocketBeagle board. It makes the process of testing PocketBeagle board ADCs easier."
    echo "This tool has three different operational modes:"
    echo " "
    echo "Mode 1: single-shot"
    echo "In this mode, a single read of counts and voltages of all ADC channels of PocketBeagle board will be done."
    echo "Usage: ./adc_tool.sh single"
    echo " "
    echo "Mode 2: countinuous"
    echo "In this mode, all ADC channels of PocketBeagle board are continuosly read, and the time between the reads can be set in command line."
    echo "Usage: ./adc_tool.sh cont TIME, where TIME stands for the time (seconds) between two consecutive reads"
    echo " "
    echo "Mode 3: custom"
    echo "In this mode, all ADC channels of PocketBeagle board are read as informed in command line, where number of reads and time between the reads are set in command line."
    echo "Usage: ./adc_tool.sh custom NUM TIME"
    echo "where:" 
    echo "* NUM stands for how many reads will be done"
    echo "* TIME stands for the time (seconds) between two consecutive reads."
fi

# Read type: Single-shot
if [ "$READ_TYPE" = "single" ]; then
    read_all_adc_channels
fi

# Read type: custom
if [ "$READ_TYPE" = "custom" ]; then

    if [ -z "$2" ]; then
       echo "Number of custom reads hasn't been informed. Then, this value will be taken as 1."
       NUM_ADC_READS=1
    else
       NUM_ADC_READS=$2
       echo "Number of custom reads: $NUM_ADC_READS"
    fi

    if [ -z "$3" ]; then
       echo "Time between custom reads hasn't been informed. Then, this value will be taken as 1 s."
       SLEEP_BETWEEN_CUSTOM_READS=1
    else
       SLEEP_BETWEEN_CUSTOM_READS=$3
       echo "Time between custom reads: $SLEEP_BETWEEN_CUSTOM_READS s"
    fi

    for i in $(seq 1 $NUM_ADC_READS)
    do
        echo "Custom read #$i / $NUM_ADC_READS:"
        read_all_adc_channels
        sleep $SLEEP_BETWEEN_CUSTOM_READS
    done
fi

# Read type: Countinuos ADC read
if [ "$READ_TYPE" = "cont" ]; then

    if [ -z "$2" ]; then
       echo "Time between reads hasn't been informed. Then, this value will be taken as 1s."
       SLEEP_SECS_BETWEEN_READS=1
    else
       SLEEP_SECS_BETWEEN_READS=$2
       echo "Time between reads: $SLEEP_SECS_BETWEEN_READS s"
    fi

    ADC_READS_COUNTER=1

    while true
    do
        echo "Read #$ADC_READS_COUNTER :"
        read_all_adc_channels
        sleep $SLEEP_SECS_BETWEEN_READS
        ADC_READS_COUNTER=$((ADC_READS_COUNTER+1))
        echo "---"
    done
fi
