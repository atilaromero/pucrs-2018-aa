+!pick_job_solo // select a job no one is doing
	: aJob(Id)
	& not doing(Id, _)
	& not avoidJob(Id) // not failed before
<-
	?.my_name(Me);
	+doing(Id, Me);
	?.all_names(All);
	// tell everyone this job is mine
	.broadcast(tell, doing(Id, Me));
	for (.member(X, All)) {
		// wait for response
		.send(X, askOne, doing(Id, X), Resp);
		+Resp;
	}
	// got all replies, check for conflicts
	!check_job_solo;
.
// couldn't select a job (maybe we just started and there are not enough jobs yet)
+!pick_job_solo
<-
	// skip to next round to avoid loop: after this fail, !solo will try again
	!try(skip); 
	.fail
.

+!check_job_solo //found a conflict
	: .my_name(Me)
	& doing(Id, Me)
	& doing(Id, X)
	& Me > X	// agent with lowest ID gets to keep the job
<-
	!leave_job(Id);
	!pick_job_solo;
.
// no conflicts
+!check_job_solo<-true.