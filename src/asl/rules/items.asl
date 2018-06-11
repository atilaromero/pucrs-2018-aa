//+item(Name, Volume, Tools, Parts) <- .print("item(name, volume, tools([tool1, ...]), parts([[item1, qty1], ...]))").
//+hasItem(Name, Qty) : true <- .print("hasItem(name, qty)", Name, Qty).

// Items a job requires
jobItems(Id, Item, Qtd) :- job(Id,_,_,_,_, Items) & 
                           .member(required(Item, Qtd), Items) &
                           Qtd > 0.

carryingOrStored(Item, Qtd, Storage) 
	:- hasItem(Item, Qh)         // I'm carrying this item
	&  stored(Item, Qs, Storage) // I also have some on storage
	&  Qtd = Qh + Qs.            // total
carryingOrStored(Item, Qtd, Storage) 
	:- hasItem(Item, Qtd)        // I have this item only with me
	&  not stored(Item, _, Storage).
carryingOrStored(Item, Qtd, Storage) 
	:- not hasItem(Item, _)
	& stored(Item, Qs, Storage).// I have this item only with in storage
		
needBuyItemForJob(Job, Item, Qtd) 
	:- jobItems(Job, Item, Qj) &              // Job requires item
	   job(Job, Storage, _, _, _, _) & 
       carryingOrStored(Item, Qh, Storage) &  // I have this item
       .max([Qj-Qh,0],Qtd) &                  // but still need Qtd
       Qtd > 0. 
needBuyItemForJob(Job, Item, Qj)  
	:- jobItems(Job, Item, Qj) &               // Job requires item  
	   job(Job, Storage, _, _, _, _) & 
       not carryingOrStored(Item, _, Storage). // I don't have this item

// Items that a Shop has
shopItems(Shop,Item,Price,Qtd) :- shop(Shop,_,_,_,Itens) & 
                                  .member(item(Item,Price,Qtd), Itens) &
                                  Qtd > 0.
