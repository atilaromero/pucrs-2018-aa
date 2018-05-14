+!choose_want(Step)
	: not doingJob(_,_,_,_,_,_)
<-
	+want(job);
	-want(buy);
	.

+!choose_want(Step)
	: batteryLow
<-
	+want(charge)
	.

+!choose_want(Step)
	: hasItem(Item,_) 
	& doingJob(_,Storage,_,_,_,Items) 
	& .member(Item, Items)
<-
	+want(deliver)
	.
	
+!choose_want(Step)
	: doingJob(_,_,_,_,_,_)
	& not buyinglist([])
<-
	+want(buy)
	.
+!choose_want(Step)
	: doingJob(_,_,_,_,_,_)
	& buyinglist([])
<-
	-want(buy)
	.