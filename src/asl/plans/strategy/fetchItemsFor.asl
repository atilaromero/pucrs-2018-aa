+!fetchItemsFor(Job)
	: needBuyItemForJob(Job, Item, Qj)   // need Item
	& shopItems(Shop,Item,_,Qs)    // Shop has Item
	& facility(Shop)               // reached Shop
	& item(Item, Volume, _, _)     // 1 Item has this Volume
	& freeLoad(Free)               // my free space
	& Free >= Volume                // I can carry that
<-
	.print("reached Shop, and Shop has needed items");
	?.min([Qj, Qs], CanBuy) // don't buy more than needed, don't buy more than store has
	?CanCarry = math.floor(Free/Volume)
	?.min([CanCarry, CanBuy], Qtd)
	!retries(4, try(buy(Item, Qtd)));
	!fetchItemsFor(Job); // check for more items
.
+!fetchItemsFor(Job)
	: needBuyItemForJob(Job, Item, Qj)   // need Item
	& shopItems(Shop,Item,_,Qs)    // Shop has Item
	& item(Item, Volume, _, _)     // 1 Item has this Volume
	& freeLoad(Free)               // my free space
	& Free >= Volume               // I can carry that
<-
	.print("choose a store to go to");
	!maybe_charge;
	!try(goto(Shop));
	!fetchItemsFor(Job);
.
+!fetchItemsFor(Job)
	: needBuyItemForJob(Job, Item, _)   // still need something
<-
	.print("couldn't buy anything");
	!unloadFor(Job);
.	
// don't need anything, fetch phase finished
+!fetchItemsFor(Job)<- true.
