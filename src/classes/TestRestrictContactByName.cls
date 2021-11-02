@isTest
public class TestRestrictContactByName {
    @isTest static void contactTest(){
     Contact con = new Contact(LastName = 'INVALIDNAME', Email = 'test@gmail.com');
        
        Test.startTest();
        Database.SaveResult result = Database.insert(con, false);
        Test.stopTest();
        
     System.assert(!result.isSuccess());
     System.assert(result.getErrors().size() > 0);
     
        
    }

    
    

}