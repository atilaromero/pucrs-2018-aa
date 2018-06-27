canRetrieveFor(Job, Shop, Item, Qtd)
:- jobItems(Job, Item, Qj)      // job requires item
&  tossed(Item,Qs, Shop)        // Shop has Item tossed
&  item(Item, Volume, _, _)     // 1 Item has this Volume
&  freeLoad(Free)               // my free space
&  Free >= Volume                // I can carry that
&  CanCarry = math.floor(Free/Volume)
&  .min([Qj, Qs], CanGet) // don't get more than needed, or more than store has
&  .min([CanCarry, CanGet], Qtd)
.

+!retrieveItems
  : canRetrieveFor(Job, Shop, Item, Qtd)
  & .my_name(Me)
  & doing(Job, Me)
  & facility(Shop)               // reached Shop
<-
  .print("reached Shop, and Shop has needed items");
  !retries(4, try(retrieve(Item, Qtd)));
  !updateTossed(Item, -Qtd, Shop)
  !retrieveItems; // check for more items
  .

+!retrieveItems
  : canRetrieveFor(Job, Shop, _, _)
  & .my_name(Me)
  & doing(Job, Me)
<-
  .print("choose a store to go to pick a tossed item");
  !maybe_charge;
  !try(goto(Shop));
  !retrieveItems
.
  
+!retrieveItems
<-
.print("can't retrieve anything, phase finished")
.
  