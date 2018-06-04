+!try(Action)
<-
	!perform_action(Action);
	.wait(false);
.

+!step(X)
	: .intend(try(Action))
	& lastActionResult(successful)
<-
	.print("succeed_goal ", try(Action));
	.succeed_goal(try(Action));
.
+!step(X)
	: .intend(try(Action))
<-
	.print("fail_goal ", try(Action));
	.fail_goal(try(Action));
.
