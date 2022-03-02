@RestResource(urlMapping='/Account/*')
global with sharing class AccountAPI {
    @HttpGet
    global static Account getAccById() {
        RestRequest request = RestContext.request;
        // grab the accId from the end of the URL
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accId];
        return result;
    }
    @HttpPost
    global static ID createAccount(String name, String phone, String website) {
        Account account = new Account(
            Name = name,
            Phone = phone,
            Website = website);
        insert account;
        return account.Id;
    }   
    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accId];
        delete account;
    }     
    @HttpPut
    global static ID upsertAccount(String id, String name, String phone, String website) {
        Account account = new Account(
                Id=id,
                Name = name,
                Phone = phone,
                Website = website);
        
        upsert account;
        return account.Id;
    }
    @HttpPatch
    global static ID updateAccountFields() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> values = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldValue : values.keySet()) {
            // Set the field and value on the Account sObject
            account.put(fieldValue, values.get(fieldValue));
        }
        update account;
        return account.Id;
    }    
}
