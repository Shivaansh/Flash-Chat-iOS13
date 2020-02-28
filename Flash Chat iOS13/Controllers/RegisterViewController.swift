//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        //mandatory, so use if let statement for optional chaining
        if let email = emailTextfield.text, let password = passwordTextfield.text
        {
            //only run if both email and password exist
            //TODO what about validating email and password? -> Handled by password
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              // ...
                //authResult is user data after successful registration
                //error is optional
                

                
                if let e = error
                {
                    //TODO handle login error
                    //print(e.localizedDescription)
                    
                    let alert = UIAlertController(title: "Error!", message: e.localizedDescription, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
                else
                {
                    //perform segue to chat view controller
                    self.performSegue(withIdentifier: "regToChat", sender: UIButton.self)
                }
            }

        }
        
                
    }
    
}
