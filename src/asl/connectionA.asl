{include("plans/charge.asl")}
{include("plans/job_done.asl")}
{include("plans/leave_job.asl")}
{include("plans/maybe_charge.asl")}
{include("plans/perform_action.asl")}
{include("plans/test.asl")}
{include("plans/step_layer/retries.asl")}
{include("plans/step_layer/try_goto.asl")}
{include("plans/step_layer/try.asl")} //must include any other try (like try_goto) before this one
{include("plans/strategy/buyItems.asl")}
{include("plans/strategy/pick_job_solo.asl")}
{include("plans/strategy/retrieveItems.asl")}
{include("plans/strategy/solo.asl")}
{include("plans/strategy/storeItem.asl")}
{include("plans/strategy/unloadFor.asl")}
{include("rules/battery.asl")}
{include("rules/items.asl")}
{include("rules/job.asl")}
{include("rules/places.asl")}
{include("rules/self.asl")}

//+!step(X)
//:	.intend(test_charge_fail_retry)
//<-
//	!perform_action(skip);
//.
//+!step(X)
//<-
//	!test_charge_fail_retry;
//.

+!step(X) // if step_layer did not kick in, we have no active strategy
<-
	!solo;
.
-!step(X) //on fail...
<-	
	!perform_action(recharge);
.

+bye<-.stopMAS.

+step(X)
: steps(MAX)
& X=MAX-1
<- 
	!step(X);
	.abolish(_); //at last step clear all beliefs to next game
.

+step(X)<-!step(X).
