{include("goals/perform_action.asl")}
{include("goals/pick_job.asl")}
{include("goals/try_goto.asl")}
{include("goals/try.asl")} //include other tries first
{include("plans/charge.asl")}
{include("plans/maybe_charge.asl")}
{include("plans/solo.asl")}
{include("plans/test.asl")}
{include("rules/battery.asl")}
{include("rules/job.asl")}
{include("rules/places.asl")}

+!step(X)
<-
	!solo;
.
-!step(X)
<-
	skip;
.

+step(X)<-!step(X).
+bye
<-
	.print("### Simulation has finished ###");
.
