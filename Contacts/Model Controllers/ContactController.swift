//
//  ContactController.swift
//  Contacts
//
//  Created by Carson Buckley on 4/12/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    //Shared Instance
    static let sharedInstance = ContactController()
    private init() {}
    
    //Source of Truth
    var contacts: [Contact] = []
    
    //Reference to DataBase (A short-hand way of referring to it)
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //CRUD
    //Create
    func createContact(name: String, phoneNumber: String, email: String, completion: @escaping (Contact?) -> Void) {
        
        //Create a new Contact
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        
        //Create a Record from new Contact
        let newRecord = CKRecord(contact: newContact)
        
        //Save that CKRecord to CloudKit
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            //Unwrap Record received
            guard let record = record else { return }
            
            //Create Contact from Record
            let contact = Contact(ckRecord: record)
            
            //Store it Locally
            guard let unwrappedContact = contact else { return }
            self.contacts.append(unwrappedContact)
            
            //Complete with Contact
            completion(contact)
        }
    }
    
    //Read
    func fetchAllContacts(completion: @escaping ([Contact]?) -> Void) {
        
        //Make a Predicate for Query
        let predicate = NSPredicate(value: true)
        
        //Make a Query for Perform
        let query = CKQuery(recordType: Constants.ContactRecordType, predicate: predicate)
        
        //Make a Fetch Request
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            //Unwrap records
            guard let records = records else { return }
            
            //Create an Array of contacts from the Records
            let contacts: [Contact] = records.compactMap { Contact(ckRecord: $0) }
            
            //Fill our Source of Truth
            self.contacts = contacts
            
            //Done
            completion(contacts)
        }
    }
    
    //Create Update Function
    func updateContact(name: String, phoneNumber: String, email: String, completion: @escaping (Contact?) -> Void) {
//        contact.name = name
//        contact.phoneNumber = phoneNumber
//        contact.email = email
        
        //Create a new Contact
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        
        //Create a Record from new Contact
        let newRecord = CKRecord(contact: newContact)
        
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            //Unwrap Record received
            guard let record = record else { return }
            
            //Create Contact from Record
            let contact = Contact(ckRecord: record)
            
            //Store it Locally
            guard let unwrappedContact = contact else { return }
            self.contacts.append(unwrappedContact)
            
            //Complete with Contact
            completion(contact)
        }
    }
    
    //Update Function
    func updateContact2(updateContact contact: Contact, completion: ((Bool) -> ())?){
        let subscriptionID = contact.ckRecordID.recordName
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: subscriptionID) { (_, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion?(false)
                return
            } else {
                print("Subscription deleted")
                completion?(true)
            }
            
        }
    }
    
    //Read CloudKit Documentation on Updating CKRecords
    
}
