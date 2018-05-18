+!goto_facility(Facility)
	: Facility
<-
	.print("There's no where to go");	
	.
+!goto_facility(Facility)
	: charge(Charge)
<-
	+going(Facility);
	.abolish(wantToLeave);
	!perform_action(goto(Facility));	
	.print("Going to ",Facility, " Charge: ", Charge);	
	.

+!goto_oneof(Facilities)
	: true
<-
	.member(Facility, Facilities);
	!goto_facility(Facility)
	.

