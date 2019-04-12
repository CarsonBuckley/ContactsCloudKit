//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Carson Buckley on 4/12/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactNameLabel: UILabel!
    
//    var cellNameLabel: Contact? {
//        didSet {
//            updateCell()
//        }
//    }

//    var contact: Contact? {
//        didSet {
//            updateView()
//        }
//    }
    
    //Update with a Function
    func updateView(with contact: Contact) {
        contactNameLabel.text = contact.name
    }
}
