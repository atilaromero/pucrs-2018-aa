hasEnoughBattery :- role(_,_,_,Battery,_) & charge(Charge) & (Charge > (Battery*0.9)).
batteryLow :- role(_,_,_,Battery,_) & charge(Charge) & (Charge <= (Battery*0.4)).
batteryOut :- role(_,_,_,Battery,_) & charge(Charge) & (Charge <= (Battery*0.2)).

+batteryLow
<-
  .print("BatteryLow");
  .
  
+batteryOut
<-
  .print("============> BatteryOut");
  .