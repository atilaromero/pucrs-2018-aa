+!try(goto(Y))
<-
	!step(X);
	.wait(false);
.
+!step(X)	// reached destination
	: .intend(try(goto(Y)))
	& facility(Y)
<-
	.succeed_goal(try(goto(Y)));
.
+!step(X)	// on route, but must recharge
	: .intend(try(goto(Y)))
	& batteryOut
<-
	!perform_action(recharge);
.
+!step(X)	// on route
	: .intend(try(goto(Y)))
<-
	!perform_action(goto(Y));
.
