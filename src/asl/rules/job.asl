//+job(Id, Storage, Reward, Start, End, Items) : true <- .print("job(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+posted(Id, Storage, Reward, Start, End, Items) : true <- .print("posted(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+auction(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items) : true <- .print("auction(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").
//+mission(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items) : true <- .print("mission(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").

aJob(Id) :- job(Id, Storage, Reward, Start, End, Items).
