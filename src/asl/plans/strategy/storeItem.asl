+!storeItem(Item, Qtd, Storage)
	: not facility(Storage)
<-
	!maybe_charge;
	!try(goto(Storage));
	!storeItem(Item, Qtd, Storage)
.
+!storeItem(Item, Qtd, Storage)
<-
	!retries(4, try(store(Item, Qtd)));
	!updateStored(Item, Qtd, Storage)
.

+!updateStored(Item, Qtd, Storage)
	:stored(Item, Qtd2, Storage)
<-
	-stored(Item, Qtd2, Storage);
	+stored(Item, Qtd+Qtd2, Storage);
.
+!updateStored(Item, Qtd, Storage)
<-
	+stored(Item, Qtd, Storage)
.

+!tossItem(Item, Qtd)
<-	
	?aStorage(Storage);
	!tossItem(Item, Qtd, Storage)
.
+!tossItem(Item, Qtd, Storage)
	: not facility(Storage)
<-	
	!maybe_charge;
	!try(goto(Storage));
.
+!tossItem(Item, Qtd, Storage)
<-	
	!retries(4, try(store(Item, Qtd)));
	!updateTossed(Item, Qtd, Storage)
.
+!updateTossed(Item, Qtd, Storage)
	:tossed(Item, Qtd2, Storage)[source(self)]
<-
	-tossed(Item, Qtd2, Storage)[source(self)];
	+tossed(Item, Qtd+Qtd2, Storage)[source(self)];
	.broadcast(tell, tossed(Item, Qtd+Qtd2, Storage))
.
+!updateTossed(Item, Qtd, Storage)
<-
	+tossed(Item, Qtd, Storage)[source(self)]
	.broadcast(tell, tossed(Item, Qtd, Storage))
.
+tossed(Item, Qtd, Storage)[source(X)]
	: Qtd <= 0
<-
	.abolish(tossed(Item, _, Storage))
.
+tossed(Item, Qtd, Storage)[source(X)]
<-
	+tossed(Item, Qtd, Storage)[source(self)]
.

+!storeAllFor(Job)
	: hasItem(Item,Qtd)	           // I'm carrying Item
	& jobItems(Job, Item, _)       // job requires Item
<-	
//	.print("I'm carrying a required Item for Job: I will store this", item(Item));
	?job(Job, Storage, _, _, _, _);
	!storeItem(Item, Qtd, Storage);	
	!storeAllFor(Job);
.
+!storeAllFor(Job)<-true. //done

+!tossAllUseless
	: hasItem(Item,Qtd)	           // I'm carrying Item
	& .my_name(Me)
	& not (doing(Job, Me)
		   & jobItems(Job, Item, _))// item not required for Job
<-
//	.print("I'm carrying a useless item (I will toss this)");
	!retries(4, tossItem(Item, Qtd));	
	!tossAllUseless;
.
+!tossAllUseless<-true. //done