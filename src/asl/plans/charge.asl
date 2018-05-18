+!charge
	: aChargingStation(Name)
<-
	!try(goto(Name));
	!try(charge);
.

+!charge
<-
	.print("No charging station");
	.fail;
.