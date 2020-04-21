//
//  SignUpViewController.swift
//  InstargramApp
//
//  Created by vfa on 4/21/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
    }
    
    @IBAction func backLoginViewActionClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
