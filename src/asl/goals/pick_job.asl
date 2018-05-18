+!pick_job
	: job(Id, _, _, _, _, _)
	& not doing(Id, _)
	& .my_name(Me)
	& .all_names(All)
<-
	+doing(Id, Me);
	for (.member(X, All)) {
		.send(X, askOne, doing(Id, X), Resp);
		+Resp;
	}
	!check_mine;
.
+!pick_job<-.fail.

+!check_mine
	: .my_name(Me)
	& doing(Id, Me)
	& doing(Id, X)
	& Me > X
<-
	.abolish(doing(Id, Me));
	.broadcast(tell, ~doing(Id, Me));
	!pick_job;
.
+!check_mine<-true.
