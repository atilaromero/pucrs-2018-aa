+!try(Action)
<-
	+try(Action);
	.abolish(retries(Action,_));
	+retries(Action, 0);
	!perform_action(Action);
	.wait({-try(Action)});
	-retries(Action, _);
.
+!step(X)
	: try(Action)
	& lastActionResult("successful")
<-
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
	!perform_action(Action);
.
+!step(X)
	: try(Action)
<-
	-retries(Action, _);
	.fail;
.
