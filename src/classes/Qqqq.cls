public class Qqqq {
    public void testMethodd(){
       AggregateResult[] groupedResults = [SELECT AVG(NumberOfEmployees) FROM Account];
         System.debug(groupedResults[0].get('expr0'));
        // 
       // Account myAccount = [SELECT Id, Name FROM Account];
        //System.debug(myAccount);exp
    }
}