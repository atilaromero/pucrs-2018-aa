+!try(goto(Y))
<-
	+try(goto(Y));
	!step(X);
	.wait({-try(goto(Y))});
.
+!step(X)
	: try(goto(Y))
	& facility(Y)
<-
	-try(goto(Y));
.
+!step(X)
	: try(goto(Y))
	& batteryOut
<-
	!perform_action(recharge);
.
+!step(X)
	: try(goto(Y))
<-
	!perform_action(goto(Y));
.
