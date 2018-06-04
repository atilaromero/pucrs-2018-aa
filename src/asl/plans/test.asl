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
	.print("alsdkjflsakdjfsa");
.
-!test_charge_fail_retry
<-.print("FAILED ========>",test_charge_fail_retry).


+!test_jobItems
<-
	for (jobItems(Job, Item, Qtd)){
		.print(jobItems(Job, Item, Qtd));
	}
.