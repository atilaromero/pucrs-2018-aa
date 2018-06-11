+!leave_job(Id)
<-
	?.my_name(Me);
	.abolish(doing(Id, Me));
	for (stored(X, Y, Z)) {
		-stored(X, Y, Z);
		!updateTossed(X, Y, Z);
	}
	.broadcast(untell, doing(Id, Me));
.