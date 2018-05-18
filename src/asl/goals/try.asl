+!try(Action)
<-
	+try(Action);
	.abolish(retries(Action,_));
	+retries(Action, 0);
	!perform_action(Action);
	.wait({-try(Action)});
.
+!step(X)
	: try(Action)
	& lastActionResult("successful")
<-
	.print("Action done: ", Action);
	-retries(Action, _);
	-try(Action);
.
+!step(X)
	: try(Action)
	& retries(Action, Z)
	& Z < 5
<-
	-retries(Action, Z);
	+retries(Action, Z+1);
	.print(Z);
	!perform_action(Action);
.
+!step(X)
	: try(Action)
<-
	.fail;
.
