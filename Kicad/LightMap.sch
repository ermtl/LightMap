EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:arduino
LIBS:w_connectors
LIBS:w_device
LIBS:LightMap-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L SW_PUSH SW1
U 1 1 54C024CA
P 3350 4200
F 0 "SW1" H 3500 4310 50  0000 C CNN
F 1 "SW_PUSH" H 3350 4120 50  0000 C CNN
F 2 "" H 3350 4200 60  0000 C CNN
F 3 "" H 3350 4200 60  0000 C CNN
	1    3350 4200
	0    -1   1    0   
$EndComp
$Comp
L R R1
U 1 1 54C02549
P 6100 3850
F 0 "R1" V 6180 3850 40  0000 C CNN
F 1 "18Ko" V 6107 3851 40  0000 C CNN
F 2 "" V 6030 3850 30  0000 C CNN
F 3 "" H 6100 3850 30  0000 C CNN
	1    6100 3850
	0    1    1    0   
$EndComp
$Comp
L C C1
U 1 1 54C02600
P 6100 4050
F 0 "C1" V 6200 4150 40  0000 L CNN
F 1 "0.1 uF" V 6200 3750 40  0000 L CNN
F 2 "" H 6138 3900 30  0000 C CNN
F 3 "" H 6100 4050 60  0000 C CNN
	1    6100 4050
	0    1    1    0   
$EndComp
$Comp
L R LDR1
U 1 1 54C02699
P 3000 4200
F 0 "LDR1" V 3100 4200 40  0000 C CNN
F 1 "100 ... 1MOhms" V 2900 4200 40  0000 C CNN
F 2 "" V 2930 4200 30  0000 C CNN
F 3 "" H 3000 4200 30  0000 C CNN
	1    3000 4200
	1    0    0    -1  
$EndComp
$Comp
L Arduino_Nano_Header J1
U 1 1 54C02973
P 8150 3450
F 0 "J1" H 8150 4250 60  0000 C CNN
F 1 "Arduino_Nano_Header" H 8150 2600 60  0000 C CNN
F 2 "" H 8150 3450 60  0000 C CNN
F 3 "" H 8150 3450 60  0000 C CNN
	1    8150 3450
	-1   0    0    1   
$EndComp
$Comp
L buzzer BZ1
U 1 1 54C02E88
P 5650 3600
F 0 "BZ1" H 5725 3650 50  0000 L CNN
F 1 "buzzer" H 5725 3550 50  0000 L CNN
F 2 "" H 5650 3600 60  0000 C CNN
F 3 "" H 5650 3600 60  0000 C CNN
	1    5650 3600
	-1   0    0    1   
$EndComp
$Comp
L GNDPWR #PWR?
U 1 1 54C0320E
P 6600 4650
F 0 "#PWR?" H 6600 4700 40  0001 C CNN
F 1 "GNDPWR" H 6600 4570 40  0000 C CNN
F 2 "" H 6600 4650 60  0000 C CNN
F 3 "" H 6600 4650 60  0000 C CNN
	1    6600 4650
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR?
U 1 1 54C0342E
P 5900 4650
F 0 "#PWR?" H 5900 4700 40  0001 C CNN
F 1 "GNDPWR" H 5900 4570 40  0000 C CNN
F 2 "" H 5900 4650 60  0000 C CNN
F 3 "" H 5900 4650 60  0000 C CNN
	1    5900 4650
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X07 P1
U 1 1 54C03556
P 7100 3850
F 0 "P1" H 7100 4250 50  0000 C CNN
F 1 "7 pins female header" H 7100 3450 50  0000 C CNN
F 2 "" H 7100 3850 60  0000 C CNN
F 3 "" H 7100 3850 60  0000 C CNN
	1    7100 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 4050 7800 4050
Wire Wire Line
	6600 4050 6600 4650
Wire Wire Line
	6350 3850 7800 3850
Wire Wire Line
	6600 3650 6600 3850
Wire Wire Line
	5700 3650 6600 3650
Connection ~ 6600 3850
Connection ~ 6600 4050
Wire Wire Line
	5700 3750 7800 3750
Wire Wire Line
	5700 3750 5700 4050
Wire Wire Line
	5700 4050 5900 4050
Wire Wire Line
	3000 3850 5850 3850
Connection ~ 5700 3850
Wire Wire Line
	3000 3850 3000 3950
Wire Wire Line
	3350 3900 3350 3850
Connection ~ 3350 3850
Wire Wire Line
	3000 4450 3000 4550
Wire Wire Line
	3000 4550 5900 4550
Wire Wire Line
	5900 4550 5900 4650
Wire Wire Line
	3350 4500 3350 4550
Connection ~ 3350 4550
Wire Wire Line
	6900 3650 7800 3650
Wire Wire Line
	6900 3950 7800 3950
Wire Wire Line
	6900 4150 7800 4150
Connection ~ 6900 3550
Connection ~ 6900 3750
Connection ~ 6900 3850
Connection ~ 6900 4050
Wire Wire Line
	5700 3550 7800 3550
Text Notes 7350 7500 0    60   ~ 12
LightMap 1.00     
Text Notes 7100 6700 0    60   ~ 0
This schematic diagram is part of the LightMap project.
Text Notes 8150 7650 0    60   ~ 0
Jan 21, 2015
$EndSCHEMATC
