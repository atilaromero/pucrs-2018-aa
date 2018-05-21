{include("plans/solo.asl")}
{include("plans/test.asl")}
{include("plans/charge.asl")}
{include("plans/fetchItemsFor.asl")}
{include("plans/job_done.asl")}
{include("plans/leave_job.asl")}
{include("plans/maybe_charge.asl")}
{include("plans/perform_action.asl")}
{include("plans/pick_job_solo.asl")}
{include("plans/try_goto.asl")}
{include("plans/try.asl")} //must include any other try (like try_goto) before this one
{include("rules/battery.asl")}
{include("rules/job.asl")}
{include("rules/places.asl")}

+!step(X)
<-
	!solo;
//	!test_jobItems;
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
