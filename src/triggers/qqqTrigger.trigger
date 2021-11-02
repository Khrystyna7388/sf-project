trigger qqqTrigger on Detail__c (before insert, after insert, before update, after update, before delete, after delete) {
   List <ID> ids = new List<ID>();
   List<Car__c> cars = new List<Car__c>();
   Map<ID, Decimal> newMap = new Map<ID, Decimal>();
   
  
    if(Trigger.isAfter){
        for(Detail__c detail: Trigger.new){
    		ids.add(detail.CarId__c);
            if(newMap.containsKey(detail.CarId__c)){
              Decimal tempPrice = newMap.get(detail.CarId__c);
                tempPrice+= detail.Price__c;
                newMap.put(detail.CarId__c, tempPrice);
            } else {
                newMap.put(detail.CarId__c, detail.Price__c);
            }
  		}
    }
  
    
    //List<AggregateResult> result = [SELECT SUM(Price__c)totalPr, CarId__c FROM Detail__c WHERE CarId__c IN : ids Group By CarId__c];
     //   for(Integer j = 0; j < result.size(); j++){
       //    cars.add(new Car__c(Id = (ID)result[j].get('CarId__c'), Total__c = (Decimal)result[j].get('totalPr')));
         
	  //  }
 
  
    
   update cars;
}