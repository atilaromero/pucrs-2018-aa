lider(Head)
  :- .all_names(All) 
  &  .sort(All, [Head | Tail]).
  
@liderBroadcastMe[atomic]
+!liderBroadcast(Ilf, Message)
: .my_name(Me)
& lider(Me)
<-
  .send(Me, Ilf, Message)
  .broadcast(Ilf, Message)
.

//@liderBroadcast[atomic]
+!liderBroadcast(Ilf, Message)
: lider(Lider)
<-
  .send(Lider, achieve, liderBroadcast(Ilf, Message))
.

+!request(Condition, Message)
<-
  if (Condition) {
    +Message
  }
.
