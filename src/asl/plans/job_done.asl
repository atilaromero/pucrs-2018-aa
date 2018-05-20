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


