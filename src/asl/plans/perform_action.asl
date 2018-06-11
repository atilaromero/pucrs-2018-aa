+!perform_action(Action)
<- 
//	?lastAction(Type);
//	?lastActionResult(Result);
//	.print(lastAction(Type));
//	.print(lastActionResult(Result));

	?charge(Charge)
	?freeLoad(Free);
	?load(Used);
	.print("perform_action: ", Action, charge(Charge), freeLoad(Free), load(Used));

	Action;
.
