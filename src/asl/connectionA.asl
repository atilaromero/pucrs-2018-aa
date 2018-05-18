{include("goals/perform_action.asl")}
{include("goals/try_goto.asl")}
{include("goals/try.asl")} //include other tries first
{include("plans/plan_charge.asl")}
{include("plans/test.asl")}
{include("rules/battery.asl")}
{include("rules/places.asl")}

+!step(X)
	: true
<-
	!plan_charge;
	skip;
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
