+!pick_job_solo
	: aJob(Id)
	& not doing(Id, _)
	& .my_name(Me)
	& .all_names(All)
<-
	+doing(Id, Me);
	.broadcast(tell, doing(Id, Me));
	for (.member(X, All)) {
		.send(X, askOne, doing(Id, X), Resp);
		+Resp;
	}
	!check_job_solo;
.
+!pick_job_solo<-.fail.

+!check_job_solo
	: .my_name(Me)
	& doing(Id, Me)
	& doing(Id, X)
	& Me > X
<-
	!leave_job(Id);
	!pick_job_solo;
	!check_job_solo;
.
+!check_job_solo<-true.