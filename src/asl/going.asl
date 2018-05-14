+!going(Step)
	: going(Destination) 
	& facility(Facility) 
	& (Destination == Facility)
<-
	-going(Destination);
	-want(go);
	.print("I have arrived at ",Destination);	
	!what_to_do_in_facility(Facility, Step);
	.
+!going(Step)
	: going(Destination)
<-
	.print("I continue going to ",Destination," at step ",Step);
	!goto_facility(Destination);
	.
