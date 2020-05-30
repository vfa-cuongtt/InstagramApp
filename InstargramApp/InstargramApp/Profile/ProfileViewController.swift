//
//  ProfileViewController.swift
//  InstargramApp
//
//  Created by vfa on 4/25/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import FirebaseAuth
class ProfileViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.brown
        print("Profile ")
        
        customNavigationButton()
    }
    
    func transiton(){
        let vc = storyboard?.instantiateViewController(identifier: Constants.Stroryboard.LoginViewController) as! LoginViewController
        
        view.window?.rootViewController = vc
//        self.present(vc, animated: true, completion: nil)
    }
    
    func customNavigationButton() {
        Utilities.setupNavigationBar(vc: self , title: "Profile", leftText: "Back", leftImg: nil, leftSelector: #selector(self.actBack(btn:)), rightText: "Logout", rightImg: nil, rightSelector: #selector(self.actRestorePurchase), isDarkBackground: false, isTransparent: true)
    }
    
    @objc func actBack(btn: UIBarButtonItem) {
        
        print("Tesssstttt")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actRestorePurchase() {
        print("Current User: \(Auth.auth().currentUser)")
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print("Logout Error:  \(logoutError)")
        }

        print("Logout User: \(Auth.auth().currentUser)")
        transiton()
    }
    

}
