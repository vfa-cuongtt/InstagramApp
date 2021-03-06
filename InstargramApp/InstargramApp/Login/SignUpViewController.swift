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
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var btnSignUp: UIButton!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        avatarImage.layer.borderWidth = 1.0
//        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
        btnSignUp.isEnabled = false
        
        // Choose image for profile image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        avatarImage.addGestureRecognizer(tapGesture)
        avatarImage.isUserInteractionEnabled = true
        
        handleTextField()
    }
    
    func handleTextField() {
        txtUsername.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: .editingChanged)
        txtEmail.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: .editingChanged)

    }
    
//    Get position on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func textFieldDidChange() {
        guard let username = txtUsername.text, !username.isEmpty,
            let email = txtEmail.text, !email.isEmpty,
            let password = txtPassword.text, !password.isEmpty
        else {
            btnSignUp.setTitleColor(.lightText, for: .normal)
            btnSignUp.isEnabled = false
            return
        }
        
        btnSignUp.setTitleColor(.white, for: .normal)
        btnSignUp.isEnabled = true
        
    }

    
    @objc func handleSelectProfileImageView() {
        // Select photo from libary
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func backLoginViewActionClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
            
            // Show//hidden keyboard
            view.endEditing(true)
            
            // Create User
            Auth.auth().createUser(withEmail: email, password: password) { (result , err ) in
                // Check the error
                if err != nil {
                    print("ERROR creating user: \(err?.localizedDescription) ")
                    return
                } else {
                    // User was created successed
                    let uid = result?.user.uid
                    
                    
                    
                    let storage = Storage.storage()
                    // Create a root reference
                    let storageRef = storage.reference(forURL: Constants.Storage.urlStorage).child("profile_image").child(uid!)
                    if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1) {
                        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                            if error != nil {
                                print("Upload faill")
                                return
                            }
                            
                            let profileImageUrl = metadata?.path
                            self.setUserInformation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!)

                        }
                    }
                    
                    
                    // Transition to the Home screen
                    self.transitionToHome()
                }
            }
        
        }
        
    }
    

    func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String) {
        let db = Firestore.firestore()
        print("profile Img URL \(profileImageUrl)")
        db.collection("users").addDocument(data: ["username": username, "email": email, "uid": uid, "profileImageUrl": profileImageUrl]) { (error) in
           if error != nil {
               self.showError("Error saving user")
           }
       }
    }
    //MARK:- Other method
    
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
    
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Stroryboard.homeViewController) as? HomeViewController
        
        print("Transition \(homeVC)")
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}

//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imga picker")
        
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            avatarImage.image = image


        }
        print(info)
        dismiss(animated: true, completion: nil)
    }
}

