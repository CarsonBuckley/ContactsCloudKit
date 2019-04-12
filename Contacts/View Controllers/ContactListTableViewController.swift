//
//  ContactListTableViewController.swift
//  Contacts
//
//  Created by Carson Buckley on 4/12/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactController.sharedInstance.fetchAllContacts { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ContactController.sharedInstance.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell
        
        let contact = ContactController.sharedInstance.contacts[indexPath.row]
        cell?.updateView(with: contact)
 
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "toEditVC" {
            let destinationVC = segue.destination as? DetailViewController
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let contact = ContactController.sharedInstance.contacts[indexPath.row]
            
            destinationVC?.contact = contact
        }
    }
}
