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
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        //hide the back button when this view is loaded
        navigationItem.hidesBackButton = true
        
        //register custom cell
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()

    }
    
    func loadMessages()
    {
                
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, err) in
        self.messages = []
        if let e = err
        {
            print("Error getting documents: \(e)")
        } else
        {
            if let documents = querySnapshot?.documents
            {
                for document in documents
                {
                    let data = document.data()
                    if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String
                    {
                        let newMessage = Message(sender: messageSender, body: messageBody)
                        self.messages.append(newMessage)
                                
                        DispatchQueue.main.async
                            {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                    }
                }
            }
        }
    }
}
    
    @IBAction func sendPressed(_ sender: UIButton) {
        //send button
        
        if let body = messageTextfield.text, let sender = Auth.auth().currentUser?.email
        {
            db.collection(K.FStore.collectionName).addDocument(data:
                [K.FStore.senderField : sender,
                 K.FStore.bodyField: body,
                 K.FStore.dateField: Date().timeIntervalSince1970
                ])
            { (error) in
                if let e = error
                {
                    print("Encountered error with data upload: \(e)")
                }else
                {
                    print("Successfully uploaded data")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
        //loadMessages()
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        
        if messages[indexPath.row].sender == Auth.auth().currentUser?.email {
            //message sent by user
            cell.senderAvatarImage.isHidden = true
            cell.avatarImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.systemPink
            cell.label.textColor = UIColor(named: K.BrandColors.lightBlue)
        }else{
            //message received by user
            cell.senderAvatarImage.isHidden = false
            cell.avatarImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor.systemBlue
            cell.label.textColor = UIColor(named: K.BrandColors.lightBlue)
        }
        
        
        return cell
    }
    
    
}
