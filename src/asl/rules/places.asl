//+entity(Name, Team, Lat, Lon, Role) : true <- .print("entity(name, team, lat, lon, role)", Name, Team, Lat, Lon, Role).
//+chargingStation(Name, Lat, Lon, Role) : true <- .print("chargingStation(name, lat, lon, rate)", Name, Lat, Lon, Role).
//+dump(Name, Lat, Lon) : true <- .print("dump(name, lat, lon)").
//+shop(Name, Lat, Lon, Restock, Items) : true <- .print("shop(name, lat, lon, restock, [item(name1, price1, qty1), ...])").
//+storage(Name, Lat, Lon, Cap, Used, Items) : true <- .print("storage(name, lat, lon, cap, used, [item(name1, stored1, delivered1), ...])").
//+workshop(Name, Lat, Lon) : true <- .print("workshop(name, lat, lon)").
//+resourceNode(Name, Lat, Lon, Resource) : true <- .print("resourceNode(name, lat, lon, resource)").
//+lat(D) : true <- .print("lat(d)", D).
//+lon(D) : true <- .print("lon(d)", D).

place(entity,Name,Lat,Lon)          :- entity(Name, Team, Lat, Lon, Role).
place(chargingStation,Name,Lat,Lon) :- chargingStation(Name, Lat, Lon, Role).
place(dump,Name,Lat,Lon)            :- dump(Name, Lat, Lon).
place(shop,Name,Lat,Lon)            :- shop(Name, Lat, Lon, Restock, Items).
place(storage,Name,Lat,Lon)         :- storage(Name, Lat, Lon, Cap, Used, Items).
place(workshop,Name,Lat,Lon)        :- workshop(Name, Lat, Lon).
place(resourceNode,Name,Lat,Lon)    :- resourceNode(Name, Lat, Lon, Resource).

//manhattan distance
mDist(Lat,Lon,D)  :- lat(LatMe) & lon(LonMe)
				  & X=LatMe-Lat
				  & Y=LonMe-Lon
				  & D=math.abs(X)+math.abs(Y).
				  
nearest(Type, Name) :- .findall(x(D,Name)
								,place(Type,Name, Lat, Lon)
								 & mDist(Lat, Lon, D)
								,AllPlaces)
					& .sort(AllPlaces, [x(D,Name)|T]).
