+!choose_my_action(Step)
	: want(job)
<-
	!chooseJob;
	!choose_my_action(Step);
	.

+!choose_my_action(Step)
	: want(charge)
<-
	!doCharge(Step);
	.
//+!choose_my_action(Step)
//	: lastAction(noAction) 
//	& realLastAction(Action)
//<-
//	.print("Recovering from fail at step ",Step);	
//	Action;
//	.
+!choose_my_action(Step)
	: want(go)
<-
	!going(Step)
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
	!choose_shop_to_go_buying(Step);
	.
+!choose_my_action(Step)
	: true
<-
	.print("===========> I'm doing nothing at step ",Step);
	.print("==");
	for (want(X)) {
		.print("want: ", X);
	}
	for (hasItem(X,Y)) {
		.print("hasItem: ", X, Y);
	}
	for (doingJob(Name,Storage,Reward,Begin,End,Requirements)) {
		.print("doing Job: ", Name,Storage,Reward,Begin,End,Requirements);
	}
	for (buyingList(X)) {
		.print("buyingList: ", X);
	}
	.print("==");
	.print("===========");
	!perform_action(skip);
	.
	