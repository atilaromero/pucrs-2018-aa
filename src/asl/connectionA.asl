{include("goals/perform_action.asl")}
{include("goals/try_goto.asl")}
{include("goals/try.asl")} //must include any other try (like try_goto) before this one
{include("plans/charge.asl")}
{include("plans/fetchItemsFor.asl")}
{include("plans/maybe_charge.asl")}
{include("plans/solo.asl")}
{include("plans/test.asl")}
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
+bye
<-
	.print("### Simulation has finished ###");
.
