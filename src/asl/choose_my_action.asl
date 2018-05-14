+!choose_my_action(Step)
	: not doingJob(_,_,_,_,_,_)
<-
	.print("Choose action: chooseJob");
	!chooseJob;
	!choose_my_action(Step);
	.

+!choose_my_action(Step)
	: batteryLow & chargingStation(Name,_,_,_) & facility(Facility) & (Facility == Name)
<-
	.print("Choose action: charge");
	!perform_action(charge);
	.
+!choose_my_action(Step)
	: batteryOut
<-
	.print("Choose action: recharge");
	!perform_action(recharge);
	.


+!choose_my_action(Step)
	: lastAction(noAction) & realLastAction(Action)
<-
	.print("Recovering from fail at step ",Step);	
	Action;
	.
+!choose_my_action(Step)
	: going(Destination) & facility(Facility) & (Destination == Facility)
<-
	-going(Destination);
	.print("I have arrived at ",Destination);	
	!what_to_do_in_facility(Facility, Step);
	.
+!choose_my_action(Step)
	: going(Destination)
<-
	.print("I continue going to ",Destination," at step ",Step);
	!goto_facility(Destination);
	.
+!choose_my_action(Step)
	: batteryLow & .findall(Name, chargingStation(Name,_,_,_), ChargeStations)
<-
	.print("Choose ChargeStation");
	!goto_oneof(ChargeStations);
	.
+!choose_my_action(Step)
	: hasItem(_,_) & doingJob(_,Storage,_,_,_,_)
<-
	.print("Going delivery item at ",Storage," at step ",Step);	
	!goto_facility(Storage);
	.
+!choose_my_action(Step)
	: doingJob(_,_,_,_,_,_)
<-
	.print("===========> I have a job and I am doing nothing");		
	!choose_shop_to_go_buying(Step);
	.
+!choose_my_action(Step)
	:true
<-
	.print("===========> I'm doing nothing at step ",Step);
	!perform_action(skip);
	.
	