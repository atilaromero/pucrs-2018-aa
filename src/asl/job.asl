//@newJob[atomic]
//+job(Name,Storage,Reward,Begin,End,Requirements)
//	: true
//<-
//	!analise_job(Name,Storage,Reward,Begin,End,Requirements);
//	.
//+!analise_job(Name,Storage,Reward,Begin,End,Requirements)
//	: doingJob(_,_,_,_,_,_)
//<-
//	-job(Name,Storage,Reward,Begin,End,Requirements);
//	.
//+!analise_job(Name,Storage,Reward,Begin,End,Requirements)
//	: true
//<-
//	.print("I received a job, we'll do it");	
//	!call_the_other_agents(Name,Storage,Reward,Begin,End,Requirements);
//	-job(Name,Storage,Reward,Begin,End,Requirements);	
//	.	

+job(Name,Storage,Reward,Begin,End,Requirements)
	: true
<-
	+job(Name,Storage,Reward,Begin,End,Requirements)
.
+mission(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items)
	: true
<-
	+mission(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items)
.

+step(Step)
	: job(Name,Storage,Reward,Begin,End,Requirements) & (Step >= End)
<-
	.print("job expired: ", Name);
	.abolish(job(Name,Storage,Reward,Begin,End,Requirements));
	.

@aJob[atomic]
+!chooseJob
	: mission(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items)
<-
	.print("I received a mission, we'll do it");	
	!call_the_other_agents(Id, Storage, Reward, Start, End, Items);
	.
@bJob[atomic]
+!chooseJob
	: job(Name,Storage,Reward,Begin,End,Requirements) 
<-
	.print("I received a job, we'll do it");	
	!call_the_other_agents(Name,Storage,Reward,Begin,End,Requirements);
	-job(Name,Storage,Reward,Begin,End,Requirements);
	.
+!chooseJob
	: true
<-
	.print("Couldnt find job");
	.
	

@callingAgents[atomic]
+!call_the_other_agents(Name,Storage,Reward,Begin,End,Requirements)
	: true
<-
	.print("Calling the other agents to join me in the job");
	.broadcast(tell,doingJob(Name,Storage,Reward,Begin,End,Requirements));
	+doingJob(Name,Storage,Reward,Begin,End,Requirements);
	-+buyingList(Requirements);
	.

+doingJob(Name,_,_,_,_,_)
	: mission(Id, _, _, _, _, _, _, _, _)
<-
	.abolish(mission(Id, _, _, _, _, _, _, _, _));
	.

+doingJob(Name,_,_,_,_,_)
	: job(Name,_,_,_,_,_)
<-
	.abolish(job(Name,_,_,_,_,_));
	.
	
//+doingJob(_,_,_,_,_,_)
//	: true
//<- 
//	!decide_the_job_to_do;
//	.
//@receivingJob[atomic]
//+!decide_the_job_to_do
//	: .findall(Name,doingJob(Name,_,_,_,_,_),Jobs)
//<- 
//	.sort(Jobs,NewListSorted);
//	
//	.length(NewListSorted,Length);
//	for ( .range(I,1,(Length-1)) ) {
//        .nth(I,NewListSorted,Source);
//        -doingJob(Name,_,_,_,_,_);
//     }
//     
//     ?doingJob(_,_,_,_,_,Requirements);
//     -+buyingList(Requirements);
//	.
	
+jobCompleted(Name)[source(Agent)]
	: true
<- 
	.print("### Job Completed ###");
	.abolish(doingJob(Name,_,_,_,_,_));
	-jobCompleted(Name)[source(Agent)];
	.

+lastAction(deliver_job)
	: lastActionResult(successful) & delivered(Name)
<-
	.print("### Job Completed ###");
	.broadcast(tell,jobCompleted(Name));
	.abolish(doingJob(Name,_,_,_,_,_));
	.abolish(delivered(Name))
	.