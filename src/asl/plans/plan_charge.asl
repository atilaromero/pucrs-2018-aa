+!plan_charge
	: aChargingStation(Name)
<-
	!try(goto(Name));
	!try(charge);
.

+!plan_charge
<-
	.print("No charging station");
	.fail;
.