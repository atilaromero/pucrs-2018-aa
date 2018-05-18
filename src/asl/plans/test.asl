+!test_goto
<-
	!try(goto(shop2));
.

+!test_charge_fail
<-
	!try(charge);
.

+!test_jobItems
<-
	for (jobItems(Job, Item, Qtd)){
		.print(jobItems(Job, Item, Qtd));
	}
.