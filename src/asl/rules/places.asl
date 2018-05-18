//+entity(Name, Team, Lat, Lon, Role) : true <- .print("entity(name, team, lat, lon, role)", Name, Team, Lat, Lon, Role).
//+chargingStation(Name, Lat, Lon, Role) : true <- .print("chargingStation(name, lat, lon, rate)", Name, Lat, Lon, Role).
//+dump(Name, Lat, Lon) : true <- .print("dump(name, lat, lon)").
//+shop(Name, Lat, Lon, Restock, Items) : true <- .print("shop(name, lat, lon, restock, [item(name1, price1, qty1), ...])").
//+storage(Name, Lat, Lon, Cap, Used, Items) : true <- .print("storage(name, lat, lon, cap, used, [item(name1, stored1, delivered1), ...])").
//+workshop(Name, Lat, Lon) : true <- .print("workshop(name, lat, lon)").
//+resourceNode(Name, Lat, Lon, Resource) : true <- .print("resourceNode(name, lat, lon, resource)").

aEntity(Name)          :- entity(Name, Team, Lat, Lon, Role).
aChargingStation(Name) :- chargingStation(Name, Lat, Lon, Role).
aDump(Name)            :- dump(Name, Lat, Lon).
aShop(Name)            :- shop(Name, Lat, Lon, Restock, Items).
aStorage(Name)         :- storage(Name, Lat, Lon, Cap, Used, Items).
aWorkshop(Name)        :- workshop(Name, Lat, Lon).
aResourceNode(Name)    :- resourceNode(Name, Lat, Lon, Resource).

shopItems(Shop,Item,Price,Qtd) :- shop(Shop,_,_,_,Itens) & .member(item(Item,Price,Qtd), Itens).

