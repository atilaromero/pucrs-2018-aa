+!storeItem(Item, Qtd, Storage)
<-
	!maybe_charge;
	!try(goto(Storage));
	!retries(4, try(store(Item, Qtd)));
	!updateStored(Item, Qtd, Storage)
.

+!updateStored(Item, Qtd, Storage)
	:stored(Item, Qtd2, Storage)
<-
	-+stored(Item, Qtd+Qtd2, Storage)
.
+!updateStored(Item, Qtd, Storage)
<-
	-+stored(Item, Qtd, Storage)
.

+!tossItem(Item, Qtd)
<-	
	?aStorage(Storage);
	!maybe_charge;
	!try(goto(Storage));
	!retries(4, try(store(Item, Qtd)));
	!updateTossed(Item, Qtd, Storage)
.
+!updateTossed(Item, Qtd, Storage)
	:tossed(Item, Qtd2, Storage)[source(self)]
<-
	-+tossed(Item, Qtd+Qtd2, Storage)[source(self)]
	.broadcast(tell, tossed(Item, Qtd+Qtd2, Storage))
.
+!updateTossed(Item, Qtd, Storage)
<-
	-+tossed(Item, Qtd, Storage)[source(self)]
	.broadcast(tell, tossed(Item, Qtd+Qtd2, Storage))
.
+tossed(Item, Qtd, Storage)[source(X)]
<-
	-+tossed(Item, Qtd, Storage)[source(self)]
.