+!choose_want(Step)
	: not doingJob(_,_,_,_,_,_)
	& not want(job)
<-
	+want(job);
	-want(buy);
	!choose_want(Step);
	.

+!choose_want(Step)
	: batteryLow
	& not want(job)
<-
	+want(charge);
	!choose_want(Step);
	.

+!choose_want(Step)
	: going(_)
	& not want(go)
<-
	+want(go);
	-want(buy);
	!choose_want(Step);
	.

+!choose_want(Step)
	: hasItem(Item,_) 
	& doingJob(_,_,_,_,_,Items)
	& .member(required(Item,_), Items)
	& not want(deliver)
<-
	+want(deliver);
	!choose_want(Step);
	.
	
+!choose_want(Step)
	: doingJob(_,_,_,_,_,_)
	& not buyinglist([])
	& not want(buy)
<-
	+want(buy);
	!choose_want(Step);
	.
+!choose_want(Step)
	: doingJob(_,_,_,_,_,_)
	& buyinglist([])
	& want(buy)
<-
	-want(buy)
	!choose_want(Step)
	.

+!choose_want(Step)
<- 1==1.