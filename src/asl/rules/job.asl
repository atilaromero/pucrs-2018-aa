//+job(Id, Storage, Reward, Start, End, Items) : true <- .print("job(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+posted(Id, Storage, Reward, Start, End, Items) : true <- .print("posted(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+auction(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items) : true <- .print("auction(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").
//+mission(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items) : true <- .print("mission(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").

aJob(Id) :- job(Id, Storage, Reward, Start, End, Items).
jobItems(Id, Item, Qtd) :- job(Id,_,_,_,_, Items) & .member(required(Item, Qtd), Items).
needJobItem(Job, Item, Qtd) :- jobItems(Job, Item, Qj) & hasItem(Item, Qh) & .max([Qj-Qh,0],Qtd) & Qtd > 0. 
needJobItem(Job, Item, Qj)  :- jobItems(Job, Item, Qj) & not hasItem(Item, _).
