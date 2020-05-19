//
//  TestViewController.swift
//  InstargramApp
//
//  Created by vfa on 5/18/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
    }
}
