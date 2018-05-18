+!solo
	: .my_name(Me)
	& not doing(_, Me)
<-
	!pick_job_solo;
	!check_job_solo;
	!solo;
.
+!solo
	: .my_name(Me)
	& doing(Job, Me)
<-
	!fetchItemsFor(Job);
	?job(Job, Storage, Reward, Start, End, Items)
	!maybe_charge;
	!try(goto(Storage));
	!try(deliver_job(Job));
	!job_done(Job);
	!leave_job(Job);
	!maybe_charge;
.

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
.
+!pick_job_solo<-.fail.

+!job_done(Id)
<-
	?.my_name(Me);
	+job_done(Id);
	.broadcast(tell, job_done(Id));
.
+job_done(Id)
<-
	.abolish(job(Id,_,_,_,_,_));
.

+!leave_job(Id)
<-
	?.my_name(Me);
	.abolish(doing(Id, Me));
	.broadcast(untell, doing(Id, Me));
.

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