//Simulation Perceptions
//+id(SimId) <- .print("id(simId)").
//+map(MapName) <- .print("map(MapName)",MapName).
//+seedCapital(Sc) <- .print("seedCapital(sc)").
//+steps(StepNumber) <- .print("steps(stepNumber)").
//+team(Name) <- .print("team(name)").
//+role(Name, Speed, Load, Battery, Tools) <- .print("role(name, speed, load, battery, [tool1, ...])").
//+item(Name, Volume, Tools, Parts) <- .print("item(name, volume, tools([tool1, ...]), parts([[item1, qty1], ...]))").
//+minLat(Coordinate) <- .print("minLat(Coordinate)").
//+maxLat(Coordinate) <- .print("maxLat(Coordinate)").
//+minLon(Coordinate) <- .print("minLon(Coordinate)").
//+maxLon(Coordinate) <- .print("maxLon(Coordinate)").
//+proximity(P) <- .print("proximity(p)").
//+cellSize(P) <- .print("cellSize(c)").

// Perceptions
//+step(Number) : true <- .print("step(number)", Number).
//+actionID(Id) : true <- .print("actionID(id)", Id); skip.
//+deadline(Time) : true <- .print("deadline(time)", Time).
//+charge(Ch) : true <- .print("charge(ch)", Ch).
//+load(Cap) : true <- .print("load(cap)", Cap).
//+lat(D) : true <- .print("lat(d)", D).
//+lon(D) : true <- .print("lon(d)", D).
//+routeLength(Ln) : true <- .print("routeLength(ln)", Ln).
//+money(M) : true <- .print("money(m)", M).
//+facility(F) : true <- .print("facility(f)", F).
//+lastAction(Type) : true <- .print("lastAction(type)", Type).
//+lastActionResult(Result) : true <- .print("lastActionResult(result)", Result).
//+hasItem(Name, Qty) : true <- .print("hasItem(name, qty)", Name, Qty).
//+route(Wps) : true <- .print("route([wp(index, lat, lon), ...])", Wps).
//+entity(Name, Team, Lat, Lon, Role) : true <- .print("entity(name, team, lat, lon, role)", Name, Team, Lat, Lon, Role).
//+chargingStation(Name, Lat, Lon, Role) : true <- .print("chargingStation(name, lat, lon, rate)", Name, Lat, Lon, Role).
//+dump(Name, Lat, Lon) : true <- .print("dump(name, lat, lon)").
//+shop(Name, Lat, Lon, Restock, Items) : true <- .print("shop(name, lat, lon, restock, [item(name1, price1, qty1), ...])").
//+storage(Name, Lat, Lon, Cap, Used, Items) : true <- .print("storage(name, lat, lon, cap, used, [item(name1, stored1, delivered1), ...])").
//+workshop(Name, Lat, Lon) : true <- .print("workshop(name, lat, lon)").
//+resourceNode(Name, Lat, Lon, Resource) : true <- .print("resourceNode(name, lat, lon, resource)").
//+job(Id, Storage, Reward, Start, End, Items) : true <- .print("job(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+posted(Id, Storage, Reward, Start, End, Items) : true <- .print("posted(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+auction(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items) : true <- .print("auction(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").
//+mission(Id, Storage, Reward, Start, End, Fine, Bid, Time, Items) : true <- .print("mission(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").

//Actions
//goto
//goto(facility)
//goto(lat, lon)
//give(agent, item, amount)
//receive
//store(item, amount)
//retrieve(item, amount)
//retrieve_delivered(item, amount)
//assemble(item)
//assist_assemble(agent)
//buy(item, amount)
//deliver_job(job)
//bid_for_job(job, bid)
//post_job(reward, duration, storage, item, amount)
//dump(item, amount)
//charge
//recharge
//continue
//skip
//abort
//gather


{include("battery.asl")}
{include("shop.asl")}
{include("job.asl")}
{include("buyinglist.asl")}

realLastAction(skip).

+bye
<-
	.print("### Simulation has finished ###");
	.
+step(X) 
	: true 
<-
	!choose_my_action(X);
	.

+lastAction(deliver_job)
	: lastActionResult(successful) & doingJob(Name,_,_,_,_,_)
<-
	.print("### Job Completed ###");
	.broadcast(tell,jobCompleted(Name));
	.abolish(doingJob(Name,_,_,_,_,_));
	.

+!goto_facility(Facility)
	: Facility
<-
	.print("There's no where to go");	
	.
+!goto_facility(Facility)
	: true
<-
	+going(Facility);
	!perform_action(goto(Facility));	
	.print("Going to ",Facility);	
	.

+!what_to_do_in_facility(Facility, Step)
	: shop(Facility,_,_,_,ListOfItens) & not buyingList([])
<- 
	!choose_item_to_buy(Step);
	.
+!what_to_do_in_facility(Facility, Step)
	: storage(Facility,_,_,_,_,_) & doingJob(Name,_,_,_,_,_)
<- 
	.print("Delivering job ",Step);
	!perform_action(deliver_job(Name));
	.
+!what_to_do_in_facility(Facility, Step)
	: true
<- 
	.print("I have nothing to do at step ",Step);
	!perform_action(skip);
	.		

+!perform_action(continue) 
<- continue.
+!perform_action(Action)
<- 
	Action;
	-+realLastAction(Action);
	.

+!updateBuyingList(Item,Qtd)
	: buyingList(List)
<-
	.delete(required(Item,Qtd),List,NewList);
	.broadcast(tell,buyingList(NewList));
	-+buyingList(NewList);
	.

