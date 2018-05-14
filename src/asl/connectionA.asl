{include("battery.asl")}
{include("buyinglist.asl")}
{include("choose_my_action.asl")}
{include("facility.asl")}
{include("goto.asl")}
{include("job.asl")}
{include("shop.asl")}

realLastAction(skip).

+bye
<-
	.print("### Simulation has finished ###");
	.
+step(X) 
	: true 
<-
	.print("Step:", X);
	!choose_my_action(X);
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

