trigger ContactTrigger on Contact (before insert, before update) {
    Set<String> newNameSet = new Set<String>();
    Set<String> existingNameSet = new Set<String>();
    
    for(Contact con: Trigger.new){
        newNameSet.add(con.FirstName + ' ' + con.LastName);
    }
    
    //System.debug(newNameSet);
    List<Contact> existingContactsList = [Select Id, Name From Contact Where Name In :newNameSet];
    
    for(Contact con: existingContactsList){
        existingNameSet.add(con.Name);
    }
    
    for(Contact con: Trigger.new){
        if(existingNameSet.containsAll(newNameSet)){
            con.FirstName.addError('Duplicate contact full name');
            con.LastName.addError('Duplicate contact full name');
        } else {
            existingNameSet.add(con.Name);
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
    Pattern MyPattern = Pattern.compile(emailRegex);
   
    	for(Contact con: Trigger.new){
		    Matcher MyMatcher = MyPattern.matcher(con.Description);
            if(MyMatcher.matches()){
                con.Description.addError('You can`t enter an email address');
            }
    }
}