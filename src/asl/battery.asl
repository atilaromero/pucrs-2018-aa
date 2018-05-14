hasEnoughBattery :- role(_,_,_,Battery,_) & charge(Charge) & (Charge > (Battery*0.9)).
batteryFull :- role(_,_,_,Battery,_) & charge(Charge) & (Charge >= (Battery*0.95)).
batteryLow :- role(_,_,_,Battery,_) & charge(Charge) & (Charge <= (Battery*0.4)).
batteryOut :- role(_,_,_,Battery,_) & charge(Charge) & (Charge <= (Battery*0.2)).

+batteryLow
<-
  .print("BatteryLow");
  .
  
+batteryOut
<-
  .print("============> BatteryOut");
  .
  
+!doCharge(Step)
	: not batteryFull 
	& chargingStation(Name,_,_,_) 
	& facility(Name) 
<-
	.print("Choose action: charge");
	!perform_action(charge);
	.

+!doCharge(Step)
	: batteryOut
<-
	.print("Choose action: recharge");
	!perform_action(recharge);
	.
	
+!doCharge(Step)
	: true
<-
	.print("want to charge, but will wait");
	-want(charge);
	!choose_my_action(Step);
	.
