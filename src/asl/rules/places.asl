aEntity(Name)          :- entity(Name, Team, Lat, Lon, Role).
aChargingStation(Name) :- chargingStation(Name, Lat, Lon, Role).
aDump(Name)            :- dump(Name, Lat, Lon).
aShop(Name)            :- shop(Name, Lat, Lon, Restock, Items).
aStorage(Name)         :- storage(Name, Lat, Lon, Cap, Used, Items).
aWorkshop(Name)        :- workshop(Name, Lat, Lon).
aResourceNode(Name)    :- resourceNode(Name, Lat, Lon, Resource).
