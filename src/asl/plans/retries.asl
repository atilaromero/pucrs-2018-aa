+!retries(M,try(Action))
<-
	!!sub_retries(M, M, try(Action));
	.wait(false);
.

+!sub_retries(M, N, try(Action))
<-
	!try(Action);
	.succeed_goal(retries(M, try(Action)));
.
-!sub_retries(M, N, try(Action))
	: N > 1
<-
	!sub_retries(M, N-1, try(Action));
.

-!sub_retries(M, N, try(Action))
<-
	.fail_goal(retries(M,try(Action)));
.
