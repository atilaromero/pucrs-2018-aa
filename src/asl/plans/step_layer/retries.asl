+!retries(M, Action)
<-
	!!sub_retries(M, M, Action);
	.wait(false);
.

+!sub_retries(M, N, Action)
<-
	!Action;
	.succeed_goal(retries(M, Action));
.
-!sub_retries(M, N, Action)
	: N > 1
<-
	!sub_retries(M, N-1, Action);
.

-!sub_retries(M, N, Action)
<-
	.fail_goal(retries(M,Action));
.
