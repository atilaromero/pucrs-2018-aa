//+team(Name) <- .print("team(name)").
//+role(Name, Speed, Load, Battery, Tools) <- .print("role(name, speed, load, battery, [tool1, ...])").
//+deadline(Time) : true <- .print("deadline(time)", Time).
//+charge(Ch) : true <- .print("charge(ch)", Ch).
//+load(Cap) : true <- .print("load(cap)", Cap).
//+money(M) : true <- .print("money(m)", M).
//+facility(F) : true <- .print("facility(f)", F).
//+hasItem(Name, Qty) : true <- .print("hasItem(name, qty)", Name, Qty).

freeLoad(X) :- load(Used) & role(_,_,Max,_,_) & X = Max-Used.