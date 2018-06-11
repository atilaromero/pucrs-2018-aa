+!fetchItemsFor(Job) // reached Shop, and Shop has need items
	: needJobItem(Job, Item, Qj)   // need Item
	& shopItems(Shop,Item,_,Qs)    // Shop has Item
	& facility(Shop)               // reached Shop
	& item(Item, Volume, _, _)     // 1 Item has this Volume
	& freeLoad(Free)               // my free space
	& Free > Volume                // I can carry that
<-
	?.min([Qj, Qs], Qtd) // don't buy more than needed, don't buy more than store has 
	!retries(4, try(buy(Item, Qtd)));
	!fetchItemsFor(Job); // check for more items
.
+!fetchItemsFor(Job) // choose a store to go to
	: needJobItem(Job, Item, Qj)   // need Item
	& shopItems(Shop,Item,_,Qs)    // Shop has Item
	& item(Item, Volume, _, _)     // 1 Item has this Volume
	& freeLoad(Free)               // my free space
	& Free >= Volume               // I can carry that
<-
	!maybe_charge;
	!try(goto(Shop));
	!fetchItemsFor(Job);
.
+!fetchItemsFor(Job) // there are items to buy out there, but I can not carry them
	: needJobItem(Job, MyItem, _)  // job requires MyItem
	& hasItem(MyItem,Qtd)	       // I'm carrying MyItem (I will store this)
<-
	?job(Job, Storage, _, _, _, _);
	!storeItem(Item, Qtd, Storage);	
	!fetchItemsFor(Job);
.
+!fetchItemsFor(Job) // there are items to buy out there, but I can not carry them
	: needJobItem(Job, Item, _)    // job requires Item
	& hasItem(AnotherItem,Qtd)	   // I'm carrying AnotherItem (I will store this)
<-
	!retries(4, tossItem(AnotherItem, Qtd));	
	!fetchItemsFor(Job);
.
+!fetchItemsFor(Job) // still need items, but I can't buy it (no offers or too heavy)
	: needJobItem(Job, Item, Qj)
<-.fail.
// don't need anything, fetch phase finished
+!fetchItemsFor(Job)<- true.
