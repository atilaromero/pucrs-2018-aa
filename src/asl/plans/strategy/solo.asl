+!solo	// got 2 jobs: drop old one (it's a solo strategy)
	: .my_name(Me)
	& doing(Job, Me)
<-
	.print("leaving job: ", job(Job));
	!leave_job(Job);
	!maybe_charge;
	!step(_)
.
+!solo	// new job
	: .my_name(Me)
	& not doing(_, Me)
<-
	!pick_job_solo;
	.print("got job!!!!!!!!!!!!!!")
	?doing(Job, Me);
	.print("my job: ", Job)
	!retrieveItems;
	!buyItems;
	?job(Job, Storage, Reward, Start, End, Items)
	!maybe_charge;
	!try(goto(Storage));
	.print("will try deliver")
	.print(job(Job, Items))
	!retries(4,try(deliver_job(Job)));
	!job_done(Job);
	.print("done: ", job(Job, Reward))
	!leave_job(Job);
	!maybe_charge;
	!step(_)
.
// job failed
-!solo
	: .my_name(Me)
	& doing(Job, Me)
<-
  .print("job failed: ", Job)
	!leave_job(Job);
	+avoidJob(Job);
	!step(_);
.
// got no jobs? try again.
-!solo<-!step(_).