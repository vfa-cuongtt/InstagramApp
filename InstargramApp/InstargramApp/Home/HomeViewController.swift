//
//  HomeViewController.swift
//  InstargramApp
//
//  Created by vfa on 4/25/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change color
        view.backgroundColor = UIColor.blue
        print("Home View")
        
        customNavigationButton()
    }

    func customNavigationButton() {
        Utilities.setupNavigationBar(vc: self , title: "Home", leftText: "Back", leftImg: nil, leftSelector: #selector(self.actBack(btn:)), rightText: "Right", rightImg: nil, rightSelector: #selector(self.actRestorePurchase), isDarkBackground: false, isTransparent: true)
    }
    
    @objc func actBack(btn: UIBarButtonItem) {
        
        print("Tesssstttt")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actRestorePurchase() {
        print("AAAAA")
    }
}
