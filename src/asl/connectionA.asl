// Agent bob in project MAPC2017.mas2j

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start 
	: true 
<- 
	.print("hello massim world.");
	.

+step(5) 
	: true 
<-
   	?shop(Name,_,_,_,_);
	.print("I'm going to ",Name);
	goto(Name);
	.
+step(X) 
	: true 
<-
	.print("Received step percept.");
	.
	
+actionID(X) 
	: true 
<- 
	.print("Determining my action");
	skip;
	.
