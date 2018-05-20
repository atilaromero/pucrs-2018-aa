+!charge
	: aChargingStation(Name)
<-
	!try(goto(Name));
	!do_charge;
.

+!charge
<-
	.print("No charging station");
	.fail;
.
+!do_charge
	: not batteryFull
<- 
	!try(charge);
.
+!do_charge<-true.