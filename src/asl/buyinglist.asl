buyingList([]).
prebuyList([]).

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

@updatePrebuyList[atomic]
+prebuyList(List)[source(Agent)]
	: (Agent \== self)
<-
	.print("Updating prebuy list");
	-prebuyList(List)[source(Agent)];
	-+prebuyList(List)[source(self)];
	.
+!updatePrebuyList(Item,Qtd)
	: prebuyList(List)
<-
	.delete(required(Item,Qtd),List,NewList);
	.broadcast(tell,prebuyList(NewList));
	-+prebuyList(NewList);
	.

		