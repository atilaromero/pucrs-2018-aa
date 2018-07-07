+!unloadFor(Job)
	: hasItem(Item,_)	           // I'm carrying Item
	& jobItems(Job, Item, _)       // job requires Item
<-
  //unload some items to open space for more	
	!storeAllFor(Job);
	!buyItems;
.
+!unloadFor(Job)
	: hasItem(Item,Qtd)	           // I'm carrying Item
	& not jobItems(Job, Item, _)   // item not required for Job
<-
  //unload some items to open space for more  
	!tossAllUseless;	
	!buyItems;
.
+!unloadFor(Job)
<-
	.print("could not unload");
	.fail;
.
