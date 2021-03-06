//
//  ViewController.swift
//  InstargramApp
//
//  Created by vfa on 4/16/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.isEnabled = false
        handleTextField()
        
    }
    
    // Auto login
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser != nil {
           print("Login user: \(Auth.auth().currentUser!)")
           Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
               self.transitionToHome()
           }
           
       }
    }
    
    // Get position on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Show/ hidden keyboard
        view.endEditing(true)
    }
    
    func handleTextField(){
        txtEmail.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: .editingChanged)

    }


    @objc func textFieldDidChange() {
        
        guard let email = txtEmail.text, !email.isEmpty, let password = txtPassword.text, !password.isEmpty else {
            btnSignIn.setTitleColor(.white, for: .normal)
            btnSignIn.isEnabled = false
            return
        }
        
        btnSignIn.setTitleColor(.white, for: .normal)
        btnSignIn.isEnabled = true
        
    }

    //MARK:- Other method

    @IBAction func transferSignUpViewActionClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signInActionClick(_ sender: Any) {
        //TODO: Check valida email ???
        
        // Create cleaned version of the text field
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Show/ hidden keyboard
        view.endEditing(true)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
//                showError("Please check email and password incorrect")
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                // Login
                self.transitionToHome()
            }
        }
    }
    
    //MARK:- Other method
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Stroryboard.homeViewController) as? HomeViewController
        
        print("Transition \(homeVC)")
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    // Check the validate
    func validateFields() -> String? {
        // check all field
        if  txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
}

