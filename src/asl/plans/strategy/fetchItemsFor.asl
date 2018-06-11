+!fetchItemsFor(Job) // reached Shop, and Shop has need items
	: needJobItem(Job, Item, Qj)
	& shopItems(Shop,Item,_,Qs)
	& facility(Shop)
	& Qs > 0
	& .min([Qj, Qs], Qtd) // don't buy more than needed, don't buy more than store has 
<-
	!retries(4, try(buy(Item, Qtd)));
	!fetchItemsFor(Job); // check for more items
.
+!fetchItemsFor(Job) // choose a store to go to
	: needJobItem(Job, Item, Qj)
	& shopItems(Shop,Item,_,Qs)
	& Qs > 0
	& .min([Qj, Qs], Qtd)
<-
	!maybe_charge;
	!try(goto(Shop));
	!fetchItemsFor(Job);
.
+!fetchItemsFor(Job) // still need items, but no store has it
	: needJobItem(Job, Item, Qj)
<-.fail.
// don't need anything, fetch phase finished
+!fetchItemsFor(Job)<- true.
