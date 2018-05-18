+!solo
	: .my_name(Me)
	& not doing(_, Me)
<-
	!pick_job;
	!check_job_solo;
	?doing(X, Me);
	.print("doing ==> ", X);
.