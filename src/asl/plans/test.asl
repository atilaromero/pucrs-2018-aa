+!test_goto
<-
	!try(goto(shop2));
.

+!test_charge_fail
<-
	!try(charge);
.

+!test_charge_fail_retry
<-
	!retries(4, try(charge));
	.print("should not print this");
.
-!test_charge_fail_retry
<-	
	.print("FAILED ========>",test_charge_fail_retry)
	!try(skip);
.


+!test_jobItems
<-
	for (jobItems(Job, Item, Qtd)){
		.print(jobItems(Job, Item, Qtd));
	}
.