+!fetchItemsFor(Job)
	: needJobItem(Job, Item, Qj)
	& shopItems(Shop,Item,_,Qs)
	& facility(Shop)
	& Qs > 0
	& .min([Qj, Qs], Qtd)
<-
	!try(buy(Item, Qtd));
	!fetchItemsFor(Job);
.
+!fetchItemsFor(Job)
	: needJobItem(Job, Item, Qj)
	& shopItems(Shop,Item,_,Qs)
	& Qs > 0
	& .min([Qj, Qs], Qtd)
<-
	!maybe_charge;
	!try(goto(Shop));
	!fetchItemsFor(Job);
.
+!fetchItemsFor(Job)
	: needJobItem(Job, Item, Qj)
<-.fail.
+!fetchItemsFor(Job)<- true.
