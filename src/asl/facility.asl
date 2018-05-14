+!what_to_do_in_facility(Facility, Step)
	: chargingStation(Facility,_,_,_) 
	& want(charge)
<- 
	!doCharge;
	.

+!what_to_do_in_facility(Facility, Step)
	: shop(Facility,_,_,_,_) 
	& want(buy)
<- 
	!choose_item_to_buy(Step);
	.
	
+!what_to_do_in_facility(Facility, Step)
	: storage(Facility,_,_,_,_,_)
	& want(deliver) 
	& doingJob(Name,Facility,_,_,_,_)
	& not performDeliver(Name)
<- 
	.print("Delivering job ",Step);
	+performDeliver(Name)
	!perform_action(deliver_job(Name));
	.
+lastAction(deliver_job)
	: lastActionResult(successful) & performDeliver(Name)
<-
	.print("#############################################");
	.broadcast(tell,jobCompleted(Name));
	.abolish(performDeliver(Name))	
	.
+!what_to_do_in_facility(Facility, Step)
	: true
<- 
	.print("=============> I have nothing to do at", Facility," at step ",Step);
	-want(deliver);
	-want(buy);
	!choose_my_action(Step);
	.	