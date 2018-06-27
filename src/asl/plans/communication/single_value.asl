+singleValue(X,Y)
<-
	for (singleValue(X,Z) & Y\==Z) {
		.abolish(singleValue(X,Z));
	}
.