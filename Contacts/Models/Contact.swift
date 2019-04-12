//
//  Contact.swift
//  Contacts
//
//  Created by Carson Buckley on 4/12/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    var name: String
    var phoneNumber: String
    var email: String
    
    let ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(name: String, phoneNumber: String, email: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.ckRecordID = ckRecordID
    }
    
    //Create a Contact from a CKRecord
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[Constants.NameKey] as? String,
        let phoneNumber = ckRecord[Constants.PhoneNumberKey] as? String,
            let email = ckRecord[Constants.EmailKey] as? String else { return nil }
        
        self.init(name: name, phoneNumber: phoneNumber, email: email, ckRecordID: ckRecord.recordID)
    }
}

//Make a CKRecord from a Contact
extension CKRecord {
    convenience init(contact: Contact) {
        
        self.init(recordType: Constants.ContactRecordType, recordID: contact.ckRecordID)
        
        self.setValue(contact.name, forKey: Constants.NameKey)
        self.setValue(contact.phoneNumber, forKey: Constants.PhoneNumberKey)
        self.setValue(contact.email, forKey: Constants.EmailKey)
    }
}

//Constant Keys
struct Constants {
    static let ContactRecordType = "Contact"
    static let NameKey = "Name"
    static let PhoneNumberKey = "PhoneNumber"
    static let EmailKey = "Email"
}
