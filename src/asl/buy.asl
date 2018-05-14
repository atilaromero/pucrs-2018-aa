shopsWithItem(Item,Shops) :- .findall(Id,(shop(Id,_,_,_,Itens) & .member(item(Item,_,_), Itens)),Shops).
shopItems(Item,Price,Qtd,Shop) :- shop(Shop,_,_,_,Itens) & .member(item(Item,Price,Qtd), Itens).

+!go_buy(Step)
	: not goingBuy(_,Item)
	& jobNeed(Job,Item,_)
	& not successBuy(Job,Item,_)
<-
	.print("broadcast: going buy ", Item);
	.broadcast(tell,goingBuy(self, Item));
	+goingBuy(self, Item)
	!go_buy(Step);
	.
+!go_buy(Step)
	: goingBuy(self,Item)
	& shopItems(Item,_,_,Shop)
	& facility(Shop)
<-
	.print("buy ", Item);
	!buy(Item, Shop);
	.
+!go_buy(Step)
	: goingBuy(self,Item)
	& shopsWithItem(Item, Shops)
<-
	!goto_oneof(Shops);
	.

+!go_buy(Step)
	: true
<-
	.print("nothing to buy, better ask new job");
	!choose_job;
	.

+!buy(Item, Shop)
	: shopItems(Item,Price,QtdShop,Shop)
	& jobNeed(Job,Item,Qtd)
<-
	!perform_action(buy(Item,Qtd));
	+performedBuy(Job,Item,Qtd);
	.
+lastAction(buy)
	: lastActionResult(successful) & performedBuy(Job,Item,Qtd)
<-
	.broadcast(tell,successBuy(Job,Item,Qtd));
	.abolish(goingBuy(self,Item));
	.abolish(performedBuy(Job,Item,Qtd));
	.

+lastAction(buy)
	: not lastActionResult(successful) & performedBuy(Job,Item,Qtd)
<-
	.abolish(goingBuy(self,Item));
	.abolish(performedBuy(Job,Item,Qtd));
  .

