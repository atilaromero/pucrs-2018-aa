buyingList([]).

@updateBuyingList[atomic]
+buyingList(List)[source(Agent)]
	: (Agent \== self)
<-
	.print("Updating buying list");
	-buyingList(List)[source(Agent)];
	-+buyingList(List)[source(self)];
	.
