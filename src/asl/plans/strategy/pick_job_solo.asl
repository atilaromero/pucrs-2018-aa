jobItemsVolume(Job, Item, VolItem)
:- jobItems(Job, Item, Qj)      // job requires item
&  item(Item, Volume, _, _)     // 1 Item has this Volume
&  VolItem = Volume * Qj
.
jobVolume(Job, Volume)
:- aJob(Job)
&  .findall(Vol, jobItemsVolume(Job, Item, Vol), Vols)
&  Volume = math.sum(Vols)
.
spaceReserved(Vol)
:- .my_name(Me)
&  .findall(Vol, doingJob(Job, Me) & jobVolume(Job, Vol), Vols)
&  Vol = math.sum(Vols)
.
dreamJob(Job)
:- jobVolume(Job, Volume)
&  freeLoad(Free)               // my free space
&  spaceReserved(Reserved)
&  Free >= Volume + Reserved   // I can carry that
.

+!pick_job_solo // select a job no one is doing
	: dreamJob(Job)
	& not doing(Job, _)
  & not avoidJob(Job) // not failed before
<-
//  .print("trying to pick job ", dreamJob(Job))
	?.my_name(Me);
	+doing(Job, Me);
	?.all_names(All);
	.broadcast(tell, doing(Job, Me)); // tell everyone this job is mine
	for (.member(X, All)) {
		.send(X, askOne, doing(Job, X), Resp); // wait for response
		+Resp; //believe in response
	}
	!check_job_solo; // got all replies, check for conflicts
//	!pick_job_solo; //comment this line to do one job at a time
.

+!pick_job_solo
: .my_name(Me)
& not doing(_, Me)
<-
  .print("couldn't select a job (maybe we just started and there are not enough jobs yet)");
	// skip to next round to avoid loop: after this fail, !solo will try again
	!try(recharge); 
	.fail
.
+!pick_job_solo.

+!check_job_solo //found a conflict
	: .my_name(Me)
	& doing(Job, Me)
	& doing(Job, X)
	& Me > X	// agent with lowest ID gets to keep the job
<-
	!leave_job(Job);
	!pick_job_solo;
.
// no conflicts
+!check_job_solo<-true.