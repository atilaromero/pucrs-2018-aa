+!try(goto(Y))
<-
	!step(X);
	.wait(false);
.
+!step(X)
	: .intend(try(goto(Y)))
	& facility(Y)
<-
	.succeed_goal(try(goto(Y)));
.
+!step(X)
	: .intend(try(goto(Y)))
	& batteryOut
<-
	!perform_action(recharge);
.
+!step(X)
	: .intend(try(goto(Y)))
<-
	!perform_action(goto(Y));
.
