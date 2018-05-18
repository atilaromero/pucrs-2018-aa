+!pick_job
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
.
+!pick_job<-.fail.

+!check_job_solo
	: .my_name(Me)
	& doing(Id, Me)
	& doing(Id, X)
	& Me > X
<-
	.abolish(doing(Id, Me));
	.broadcast(tell, ~doing(Id, Me));
	!pick_job;
	!check_job_solo;
.
+!check_job_solo<-true.
