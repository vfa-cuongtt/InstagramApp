//
//  ActivityViewController.swift
//  InstargramApp
//
//  Created by vfa on 4/25/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
        
        customNavigationButton()
    }
    

    func transition () {
        
    }
    
    func customNavigationButton() {
        Utilities.setupNavigationBar(vc: self , title: "Activity", leftText: "Back", leftImg: nil, leftSelector: #selector(self.actBack(btn:)), rightText: "Right", rightImg: nil, rightSelector: #selector(self.actRestorePurchase), isDarkBackground: false, isTransparent: true)
    }
    
    @objc func actBack(btn: UIBarButtonItem) {
        
        print("Tesssstttt")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actRestorePurchase() {
        print("AAAAA")
    }

}
