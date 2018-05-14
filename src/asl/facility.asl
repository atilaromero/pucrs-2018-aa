+!what_to_do_in_facility(Facility, Step)
	: chargingStation(Facility,_,_,_) & not hasEnoughBattery
<- 
	!perform_action(charge);
	.

+!what_to_do_in_facility(Facility, Step)
	: shop(Facility,_,_,_,FList) & not buyingList([])
<- 
	!choose_item_to_buy(Step);
	.
+!what_to_do_in_facility(Facility, Step)
	: storage(Facility,_,_,_,_,_) & doingJob(Name,Facility,_,_,_,_)
<- 
	.print("Delivering job ",Step);
	+delivered(Name)
	!perform_action(deliver_job(Name));
	.
	
+!what_to_do_in_facility(Facility, Step)
	: true
<- 
	.print("=============> I have nothing to do at", Facility," at step ",Step);
	!perform_action(skip);
	.	