//
//  SignUpViewController.swift
//  InstargramApp
//
//  Created by vfa on 4/21/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
//    var ref: DatabaseReference
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
    }
    
    @IBAction func backLoginViewActionClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Check the validate
    func validateFields() -> String? {
        // check all field
        if txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPassword.text?.trimmingCharacters(in:.whitespacesAndNewlines) == ""{
            return "Please fill in all field"
        }
        // Check password is secure
        let cleanedPassword = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special characters and number"
        }
        
        return nil
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func signUpActionClick(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            // Create the user
            let username = txtUsername.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result , err ) in
                // Check the error
                if err != nil {
                    print("ERROR creating user: \(err?.localizedDescription) ")
                    return
                } else {
                    // User was created successed
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["username": username, "email": email, "uid": result?.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Error saving user")
                        }
                    }
                    // Transition to the Home screen
                    self.transitionToHome()
                }
            }
        
        }
        
    }
    
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Stroryboard.homeViewController) as? HomeViewController
//        let homeVC = storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
        
        print("Transition \(homeVC)")
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    

}
