shopHasItem(Item,Qtd,ListOfItens) :- .member(item(Item,_,QtdInShop),ListOfItens) & (Qtd <= QtdInShop).

shopsHasItem(Item,Qtd,[],Temp,Result) :- Result = Temp.
shopsHasItem(Item,Qtd,[shop(IdShop,ItensShop) | ListOfShops],Temp,Result) :- shopHasItem(Item,Qtd,ItensShop) & shopsHasItem(Item,Qtd,ListOfShops,[IdShop | Temp],Result).
shopsHasItem(Item,Qtd,[shop(IdShop,ItensShop) | ListOfShops],Temp,Result) :- shopsHasItem(Item,Qtd,ListOfShops,Temp,Result).
shopsHasItem(Item,Qtd,Result) :- .findall(shop(IdShop,ItensShop),shop(IdShop,_,_,_,ItensShop),ListOfShops) & shopsHasItem(Item,Qtd,ListOfShops,[],Result).

shopsWithItem(Item,Shops) :- .findall(Id,(shop(Id,_,_,_,Itens) & .member(item(Item,_,_), Itens)),Shops).
shopItems(Item,Price,Qtd,Shop) :- shop(Shop,_,_,_,Itens) & .member(item(Item,Price,Qtd), Itens).

+!choose_shop_to_go_buying(Step)
	: buyingList(Requirements) & .member(required(Item,Qtd),Requirements) & shopsHasItem(Item,Qtd,ShopList)
<-
	!updatePrebuyList(Item,Qtd);
	!goto_oneof(ShopList);
	.
+!choose_shop_to_go_buying(Step)
	: true
<- 
	!chooseJob;
	!choose_my_action(Step);
	.
	
+!choose_item_to_buy(Step)
	: buyingList(Requirements) & .member(required(Item,Qtd),Requirements) & shopsHasItem(Item,Qtd,ShopList)
<-
	!perform_action(buy(Item,Qtd));
	!updateBuyingList(Item,Qtd);
	.print("I bought ",Item," at step ",Step);
	.
+!choose_item_to_buy(Step)
	: true
<-
	!choose_shop_to_go_buying(Step);
	.
	
