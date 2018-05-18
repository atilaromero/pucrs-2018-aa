buyingList([]).

@updateBuyingList[atomic]
+buyingList(List)[source(Agent)]
	: (Agent \== self)
<-
	.print("Updating buying list");
	-buyingList(List)[source(Agent)];
	-+buyingList(List)[source(self)];
	.
+!updateBuyingList(Item,Qtd)
	: buyingList(List)
<-
	.delete(required(Item,Qtd),List,NewList);
	.broadcast(tell,buyingList(NewList));
	-+buyingList(NewList);
	.

