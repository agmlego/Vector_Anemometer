
void main() {
	int q, q0, q1, q2, sum;
	top:
	q0  = 0; 
	q1  = 0;
	q2 = 0;
	
	while( 1 /* Loop for 1 second */) {
		if( /*clock is 0*/ ) {
		
			//data1 data0 is the binary address of one of the transistors
			if(1 /* data1*/) {
				q1 += 1;
			} else if (1 /* data0*/) {
				q2 += 1;
			} else {
				q0 += 1;
			}
		}
		while( /*clock is 0*/ ); //Wait for next clock cycle
	}
	
	sum = q0+q1+q2;
	//AIRSPEED is scale*sum*sum

	//If airspeed is 0 then there is no bearing
	if (sum != 0) {
		if( q0 < q1) {
			a = q1;
			b = q2; 
			c = q0;
			g = 120;
		} else {
			a = q0;
			b = q1;
			c = q2;
			g = 0;
		} else if (q1 < q2) {
			a = q2;
			b = q0;
			c = q1;
			g = 240;
		} else {
			a = q0;
			b = q1;
			c = q2;
			g = 0;
		}
		d = a + b - 2*c;
		if(d > 0) {
			//BEARING is g + abs( (120.0 * (b - c)) / d)
		} else {
			//I'm not sure what it means if d = 0
		}
	}	
}

