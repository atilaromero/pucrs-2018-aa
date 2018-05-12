@newJob[atomic]
+job(Name,Storage,Reward,Begin,End,Requirements)
	: true
<-
	!analise_job(Name,Storage,Reward,Begin,End,Requirements);
	.
+!analise_job(Name,Storage,Reward,Begin,End,Requirements)
	: doingJob(_,_,_,_,_,_)
<-
	-job(Name,Storage,Reward,Begin,End,Requirements);
	.
+!analise_job(Name,Storage,Reward,Begin,End,Requirements)
	: true
<-
	.print("I received a job, we'll do it");	
	!call_the_other_agents(Name,Storage,Reward,Begin,End,Requirements);
	-job(Name,Storage,Reward,Begin,End,Requirements);	
	.	

@callingAgents[atomic]
+!call_the_other_agents(Name,Storage,Reward,Begin,End,Requirements)
	: not doingJob(_,_,_,_,_,_)
<-
	.print("Calling the other agents to join me in the job");
	.broadcast(tell,doingJob(Name,Storage,Reward,Begin,End,Requirements));
	+doingJob(Name,Storage,Reward,Begin,End,Requirements);
	-+buyingList(Requirements);
	.
+!call_the_other_agents(Name,Storage,Reward,Begin,End,Requirements)
	: true
<-
	.print("I will help in another job");
	.	
	
+doingJob(_,_,_,_,_,_)
	: true
<- 
	!decide_the_job_to_do;
	.
@receivingJob[atomic]
+!decide_the_job_to_do
	: .findall(Name,doingJob(Name,_,_,_,_,_),Jobs)
<- 
	.sort(Jobs,NewListSorted);
	
	.length(NewListSorted,Length);
	for ( .range(I,1,(Length-1)) ) {
        .nth(I,NewListSorted,Source);
        -doingJob(Name,_,_,_,_,_);
     }
     
     ?doingJob(_,_,_,_,_,Requirements);
     -+buyingList(Requirements);
	.
	
+jobCompleted(Name)[source(Agent)]
	: true
<- 
//	-doingJob(Name,_,_,_,_,_);
	.print("### Job Completed ###");
	.abolish(doingJob(Name,_,_,_,_,_));
	-jobCompleted(Name)[source(Agent)];
	.
