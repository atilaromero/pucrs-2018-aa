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

+!step(X)	//lastActionResult not successful
	: .intend(try(Action))
<-
	?lastActionResult(Result);
	.print("fail_goal ", try(Action), lastActionResult(Result));
	.fail_goal(try(Action));
.
