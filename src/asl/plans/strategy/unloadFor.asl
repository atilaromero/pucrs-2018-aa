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
