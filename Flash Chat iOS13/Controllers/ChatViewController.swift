//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [Message] = [
    Message(sender: "shiv@stark.us", body: "ISSA you there?"),
    Message(sender: "issa@stark.us", body: "For you sir, always."),
    Message(sender: "shiv@stark.us", body: "Alright, calm me down.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        //hide the back button when this view is loaded
        navigationItem.hidesBackButton = true
        
        

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        //send button
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        //logout button
        let firebaseAuth = Auth.auth()
        do
        {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)

        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
    
    
}
