+!perform_action(Action)
<- 
//	?lastAction(Type);
//	?lastActionResult(Result);
//	.print(lastAction(Type));
//	.print(lastActionResult(Result));

	?charge(Charge)
	?freeLoad(Free);
	.print("perform_action: ", Action, charge(Charge), freeLoad(Free));

	Action;
.
