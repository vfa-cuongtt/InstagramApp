//
//  Common.swift
//  InstargramApp
//
//  Created by vfa on 5/17/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

class Utilities {
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
