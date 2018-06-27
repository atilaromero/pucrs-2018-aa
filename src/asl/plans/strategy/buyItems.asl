canBuyFor2(Job, Shop, Item, Qtd, CanCarry, Qj, Qs)
:- needBuyItemForJob(Job, Item, Qj)
&  shopItems(Shop,Item,_,Qs)     // Shop has Item
&  item(Item, Volume, _, _)     // 1 Item has this Volume
&  freeLoad(Free)               // my free space
&  Free >= Volume                // I can carry that
&  CanCarry = math.floor(Free/Volume)
& .min([CanCarry, Qj, Qs], Qtd) // don't get more than needed, or more than store has
.


canBuyFor(Job, Shop, Item, Qtd)
:- needBuyItemForJob(Job, Item, Qj)
&  shopItems(Shop,Item,_,Qs)     // Shop has Item
&  item(Item, Volume, _, _)     // 1 Item has this Volume
&  freeLoad(Free)               // my free space
&  Free >= Volume                // I can carry that
&  CanCarry = math.floor(Free/Volume)
& .min([Qj, Qs], CanGet) // don't get more than needed, or more than store has
& .min([CanCarry, CanGet], Qtd)
.

+!buyItems
  : canBuyFor(Job, Shop, Item, Qtd)
  & facility(Shop)               // reached Shop
  & .my_name(Me)
  & doing(Job, Me)
<-
  .print("reached Shop, and Shop has needed items ");
  .print(canBuyFor(Job, Shop, Item, Qtd))
  for (jobItems(Job, X, Qj)){
    .print(jobItems(Job, X, Qj))
  }
  for (canBuyFor2(Job, Shop, X, Y, Z, Q,S)){
    .print(canBuyFor2(Job, Shop, X, Y, Z, Q,S))
  }
  !retries(4, try(buy(Item, Qtd)));
  !buyItems; // check for more items
.

+!buyItems
  : nearest(shop, Shop)
  & canBuyFor(Job, Shop, _, _)
  & .my_name(Me)
  & doing(Job, Me)
<-
  .print("choose a store to go to buy something");
  !maybe_charge;
  !try(goto(Shop));
  !buyItems;
.

+!buyItems
  : needBuyItemForJob(Job, Item, _)   // still need something
  & .my_name(Me)
  & doing(Job, Me)
<-
  .print("couldn't buy anything");
  !unloadFor(Job);
. 

+!buyItems
<-
  .print("finished buying stuff")
.