@isTest
private class SmartFactory_Test {
	static testMethod void createsSingleObjectWithSingleRequiredStringField() {
		Account account = (Account)SmartFactory.createSObject('Account');
		insert account;
		System.assert(account.Id != null);
		System.assert(account.Name != null);
	}
	
	static testMethod void createsObjectWithCascadeSetsLookupField() {
		Contact contact = (Contact)SmartFactory.createSObject('Contact', true);
		insert contact;
		System.assert(contact.Id != null);
		System.assert(contact.AccountId != null);
	}
	
	static testMethod void createsObjectWithoutCascadeDoesNotSetLookupField() {
		Contact contact = (Contact)SmartFactory.createSObject('Contact', false);
		insert contact;
		System.assert(contact.AccountId == null);
	}
	
	static testMethod void createObjectWithUnsupportedTypeThrowsException() {
		try {
			SmartFactory.createSObject('Unsupported');
			System.assert(false);
		} catch (UnsupportedObjectTypeException ex) {
			System.assert(true);
		}
	}
	
	static testMethod void generatedHelperClassHasAllObjects() {
		string body = SmartFactory.generateHelperClass();
		
		for (string sObjectType : Schema.getGlobalDescribe().keySet()) {
			System.assert(body.contains(sObjectType));
		}		
	}
}