' Thermal Vector Transistor Anemometer Demo ... W. S. Woodward, 1996
     anacal = 1: ' airspeed scale factor
     tick% = 18.2065: '... # of MSDOS-compatible Time-of-Day
     "ticktocks"/second
     DEF SEG = 0: ' T.O.D. clock lives at memory addresses (&H46C,D)

' Pick a parallel port base address from the three a-priori possibilities
pp% = &H379: ' LPT1
IF INP(pp% + 1) = 255 THEN
	pp% = &H3BD: ' LPT2
IF INP(pp% + 1) = 255 THEN
	pp% = &H279: ' Last (and least)...LPT3
IF INP(pp% + 1) = 255 THEN
	PRINT "***ERROR...Parallel Port NOT Found***"; CHR$(7): STOP

windvane:
'Initialize sensor heatpulse sums
q0% = 0
q1% = 0
q2% = 0

tclk% = PEEK(&H46C) ' Sample Time-of-Day cell

FOR i% = 1 TO tick% ' Setup to sum heat pulses for ~1 second
	WHILE PEEK(&H46C) = tclk%
		q% = INP(pp%) AND &H70 ' Check for a heater pulse
		IF q% < &H40 THEN
			IF q% = &H10 THEN
				q1% = q1% + 1
			ELSE
				IF q% THEN 
					q2% = q2% + 1
				ELSE
					q0% = q0% + 1
		WHILE (q% OR INP(pp%)) < &H40: WEND 'Busy loop
	WEND
	tclk% = PEEK(&H46C)
NEXT: ' Tally clock ticktocks 'til 18 are accounted for
   
sum% = q0% + q1% + q2%
PRINT USING "####.# "; anacal * sum% * sum%; 'AIRSPEED

IF sum% = 0 THEN
	PRINT
	GOTO windvane
 
IF q0% < q1% THEN
	IF q0% < q2% THEN
		a% = q1%
		b% = q2%
		c% = q0%
		g = 120
	ELSE
		a% = q0%
		b% = q1%
		c% = q2%
		g = 0
ELSE IF q1% < q2% THEN
	a% = q2%
	b% = q0%
	c% = q1%
	g = 240
ELSE
	a% = q0%
	b% = q1%
	c% = q2%
	g = 0

d% = a% + b% - c% - c%
IF
	d% > 0 THEN PRINT USING "###"; g + ABS(120 * ((b% - c%) / d%)) 'DIRECTION
ELSE
	PRINT 
 
GOTO windvane
