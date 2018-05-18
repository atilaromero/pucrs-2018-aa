batteryFull :- role(_,_,_,Battery,_) & charge(Charge) & (Charge >= (Battery*0.95)).
batteryLow :- role(_,_,_,Battery,_) & charge(Charge) & (Charge <= (Battery*0.4)).
batteryOut :- role(_,_,_,Battery,_) & charge(Charge) & (Charge <= (Battery*0.2)).
