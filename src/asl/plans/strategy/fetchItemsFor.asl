+!fetchItemsFor(Job)
	: needBuyItemForJob(Job, Item, Qj)   // need Item
	& shopItems(Shop,Item,_,Qs)    // Shop has Item
	& facility(Shop)               // reached Shop
	& item(Item, Volume, _, _)     // 1 Item has this Volume
	& freeLoad(Free)               // my free space
	& Free >= Volume                // I can carry that
<-
	.print("reached Shop, and Shop has needed items");
	?.min([Qj, Qs], Qtd) // don't buy more than needed, don't buy more than store has 
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

+!unloadFor(Job)
	: hasItem(Item,_)	           // I'm carrying Item
	& jobItems(Job, Item, _)       // job requires Item
<-	
	!storeAllFor(Job);
	!fetchItemsFor(Job);
.
+!unloadFor(Job)
	: hasItem(Item,Qtd)	           // I'm carrying Item
	& not jobItems(Job, Item, _)   // item not required for Job
<-
	!tossAllUseless;	
	!fetchItemsFor(Job);
.
+!unloadFor(Job)
<-
	.print("could not unload");
	.fail;
.

+!storeAllFor(Job)
	: hasItem(Item,Qtd)	           // I'm carrying Item
	& jobItems(Job, Item, _)       // job requires Item
<-	
	.print("I'm carrying a required Item for Job: I will store this", item(Item));
	?job(Job, Storage, _, _, _, _);
	!storeItem(Item, Qtd, Storage);	
	!storeAllFor(Job);
.
+!storeAllFor(Job)<-true. //done

+!tossAllUseless
	: hasItem(Item,Qtd)	           // I'm carrying Item
	& not jobItems(Job, Item, _)   // item not required for Job
<-
	.print("I'm carrying a useless item (I will toss this)");
	!retries(4, tossItem(Item, Qtd));	
	!tossAllUseless;
.
+!tossAllUseless<-true. //done