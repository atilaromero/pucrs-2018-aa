// Agent bob in project MAPC2017.mas2j

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

// Perceptions
+step(Number) : true <- .print("step(number)", Number).
+actionID(Id) : true <- .print("actionID(id)", Id); skip.
//+deadline(Time) : true <- .print("deadline(time)", Time).
+charge(Ch) : true <- .print("charge(ch)", Ch).
+load(Cap) : true <- .print("load(cap)", Cap).
//+lat(D) : true <- .print("lat(d)", D).
//+lon(D) : true <- .print("lon(d)", D).
//+routeLength(Ln) : true <- .print("routeLength(ln)", Ln).
+money(M) : true <- .print("money(m)", M).
//+facility(F) : true <- .print("facility(f)", F).
+lastAction(Type) : true <- .print("lastAction(type)", Type).
+lastActionResult(Result) : true <- .print("lastActionResult(result)", Result).
//+hasItem(Name, Qty) : true <- .print("hasItem(name, qty)", Name, Qty).
//+route(Wps) : true <- .print("route([wp(index, lat, lon), ...])", Wps).
//+entity(Name, Team, Lat, Lon, Role) : true <- .print("entity(name, team, lat, lon, role)", Name, Team, Lat, Lon, Role).
//+chargingStation(Name, Lat, Lon, Role) : true <- .print("chargingStation(name, lat, lon, rate)", Name, Lat, Lon, Role).
//+dump(Name, Lat, Lon) : true <- .print("dump(name, lat, lon)").
//+shop(Name, Lat, Lon, Restock, Items) : true <- .print("shop(name, lat, lon, restock, [item(name1, price1, qty1), ...])").
//+storage(name, lat, lon, cap, used, items) : true <- .print("storage(name, lat, lon, cap, used, [item(name1, stored1, delivered1), ...])").
//+workshop(name, lat, lon) : true <- .print("workshop(name, lat, lon)").
//+resourceNode(name, lat, lon, resource) : true <- .print("resourceNode(name, lat, lon, resource)").
//+job(id, storage, reward, start, end, items) : true <- .print("job(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+posted(id, storage, reward, start, end, items) : true <- .print("posted(id, storage, reward, start, end, [required(name1, qty1), ...])").
//+auction(id, storage, reward, start, end, fine, bid, time, items) : true <- .print("auction(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").
//+mission(id, storage, reward, start, end, fine, bid, time, items) : true <- .print("mission(id, storage, reward, start, end, fine, bid, time, [required(name1, qty1), ...])").

	