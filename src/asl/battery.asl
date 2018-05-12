hasEnoughBattery :- role(_,_,_,Battery,_) & charge(Charge) & (Charge > (Battery*0.8)).

+!recharge_vehicle(Step)
<- 
	.print("Recharging at ",Step);
	!perform_action(charge);
	.
