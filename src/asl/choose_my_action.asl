+!choose_my_action(Step)
	: want(job)
<-
//	.print("Choose action: chooseJob");
	!chooseJob;
	!choose_my_action(Step);
	.

+!choose_my_action(Step)
	: want(charge)
<-
	!doCharge(Step);
	.
+!choose_my_action(Step)
	: lastAction(noAction) 
	& realLastAction(Action)
<-
	.print("Recovering from fail at step ",Step);	
	Action;
	.
+!choose_my_action(Step)
	: going(Destination) 
	& facility(Facility) 
	& (Destination == Facility)
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
	: want(charge)
<-
	.print("Choose ChargeStation");
	!goto_oneof(ChargeStations);
	.
+!choose_my_action(Step)
	: want(deliver)
<-
	.print("Going delivery item at ",Storage," at step ",Step);	
	!goto_facility(Storage);
	.
+!choose_my_action(Step)
	: want(buy)
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
	