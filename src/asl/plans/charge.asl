+!charge
	: nearest(chargingStation,Name)
<-
	!try(goto(Name));
	!do_charge; // at charging station ?Name
.

+!charge
<-
	.print("No charging station");
	.fail;
.
+!do_charge // at charging station ?Name
	: not batteryFull
<- 
	!retries(4,try(charge)); // this is the Action charge, not the intention !charge
	!do_charge;   // repeat
.
+!do_charge<-true.