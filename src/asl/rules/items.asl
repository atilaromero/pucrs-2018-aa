//+item(Name, Volume, Tools, Parts) <- .print("item(name, volume, tools([tool1, ...]), parts([[item1, qty1], ...]))").
//+hasItem(Name, Qty) : true <- .print("hasItem(name, qty)", Name, Qty).

// Items a job requires
jobItems(Id, Item, Qtd) :- job(Id,_,_,_,_, Items) & 
                           .member(required(Item, Qtd), Items) &
                           Qtd > 0.
carryingOrStored(Item, Qtd, Storage) 
	:- .findall(Qh, hasItem(Item, Qh), A)         // I'm carrying this item
	&  .findall(Qs, stored(Item, Qs, Storage), B) // I may have some on storage
	&  .findall(Qt, tossed(Item, Qt, Storage), C) // I may have some tossed away
	&  .concat(A,B,C,Total)
	&  Qtd = math.sum(Total)
	&  Qtd > 0.
		
needBuyItemForJob(Job, Item, Qtd) 
	:- jobItems(Job, Item, Qj) &              // Job requires item
	   job(Job, Storage, _, _, _, _) & 
       carryingOrStored(Item, Qh, Storage) &  // I have this item
       Qtd == Qj-Qh &                   // but still need Qtd
       Qtd > 0.
needBuyItemForJob(Job, Item, Qj)  
	:- jobItems(Job, Item, Qj) &               // Job requires item  
	   job(Job, Storage, _, _, _, _) & 
       not carryingOrStored(Item, _, Storage). // I don't have this item

// Items that a Shop has
shopItems(Shop,Item,Price,Qtd) :- shop(Shop,_,_,_,Itens) & 
                                  .member(item(Item,Price,Qtd), Itens) &
                                  Qtd > 0.
