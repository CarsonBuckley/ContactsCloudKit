//
//  DetailTableViewController.swift
//  Contacts
//
//  Created by Carson Buckley on 4/12/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let contact = contact else { return }
        ContactController.sharedInstance.fetchAllContacts { (_) in
            DispatchQueue.main.async {
                self.view.reloadInputViews()
            }
        }
    }
    
    @objc func updateViews() {
        guard let contact = contact else { return }
        nameTextfield.text = contact.name
        phoneNumberTextfield.text = contact.phoneNumber
        emailTextfield.text = contact.email
        view.reloadInputViews()
        
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        ContactController.sharedInstance.createContact(name: nameTextfield.text ?? "", phoneNumber: phoneNumberTextfield.text ?? "", email: emailTextfield.text ?? "") { (_) in
            self.loadViewIfNeeded()
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
