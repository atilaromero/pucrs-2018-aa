{include("plans/charge.asl")}
{include("plans/job_done.asl")}
{include("plans/leave_job.asl")}
{include("plans/maybe_charge.asl")}
{include("plans/perform_action.asl")}
{include("plans/test.asl")}
{include("plans/step_layer/retries.asl")}
{include("plans/step_layer/try_goto.asl")}
{include("plans/step_layer/try.asl")} //must include any other try (like try_goto) before this one
{include("plans/strategy/fetchItemsFor.asl")}
{include("plans/strategy/pick_job_solo.asl")}
{include("plans/strategy/solo.asl")}
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

+!step(X) // if step_layer did not kick in, we got no active strategy
<-
	!solo;
.
-!step(X) //on fail...
<-
	!perform_action(skip);
.

+step(X)<-!step(X).
+bye[source(perceipt)]
<-
	.print("### Simulation has finished ###");
	.abolish(_);
.
