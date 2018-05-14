{include("battery.asl")}
{include("buyinglist.asl")}
{include("choose_my_action.asl")}
{include("facility.asl")}
{include("goto.asl")}
{include("going.asl")}
{include("job.asl")}
{include("shop.asl")}
{include("want.asl")}

realLastAction(skip).

+bye
<-
	.print("### Simulation has finished ###");
	.
+step(X) 
	: true 
<-
	.print("Step:", X);
	!choose_want(X);
	!print_want;
	!choose_my_action(X);
	.
	
+!print_want
	: true
<-
	for (want(X)){
		.print("want: ", X);
	}
	.

+!perform_action(continue) 
<- 
	.print("perform_action: ", continue, " Charge: ", Charge);
	continue;
	.
+!perform_action(Action)
	: charge(Charge)
<- 
	.print("perform_action: ", Action, " Charge: ", Charge);
	Action;
	-+realLastAction(Action);
	.

