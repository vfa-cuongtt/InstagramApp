//
//  Common.swift
//  InstargramApp
//
//  Created by vfa on 5/17/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    /// Create navigation bar
    ///
    /// - Parameters:
    ///   - vc: view controller init
    ///   - title: title screen
    ///   - leftText: left item bar
    ///   - leftImg: image left item bar
    ///   - leftSelector: action left item bar
    ///   - rightText: right item bar
    ///   - rightImg: image right item bar
    ///   - rightSelector: action right item bar
    ///   - isDarkBackground: background color
    ///   - isTransparent: transparent navigation
    static func setupNavigationBar(vc: UIViewController, title: String? = nil, leftText: String? = nil, leftImg: UIImage? = nil, leftSelector: Selector? = nil, rightText: String? = nil, rightImg: UIImage? = nil, rightSelector: Selector? = nil, isDarkBackground: Bool? = false, isTransparent: Bool? = false) -> Void {
        
        vc.navigationItem.hidesBackButton = true
        
        if title != nil {
            vc.navigationItem.title = title
            vc.navigationController?.isNavigationBarHidden = false
        } else {
            vc.navigationController?.isNavigationBarHidden = true
        }
        
        let textColor = isDarkBackground! ? UIColor.white : UIColor.black
        
        vc.navigationController?.navigationBar.tintColor = textColor
        
        /// Init Left item bar
        if leftImg != nil && leftSelector != nil {
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImg, style: .plain, target: vc, action: leftSelector)
        } else if leftText != nil && leftSelector != nil {
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftText, style: .plain, target: vc, action: leftSelector)
            vc.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        } else {
            vc.navigationItem.leftBarButtonItem = nil
        }
        
        /// Init Right item bar
        if rightImg != nil && rightSelector != nil {
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg, style: .plain, target: vc, action: rightSelector)
        } else if rightText != nil && rightSelector != nil {
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightText, style: .plain, target: vc, action: rightSelector)
            vc.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        } else {
            vc.navigationItem.rightBarButtonItem = nil
        }
        
        if isTransparent != nil && isTransparent! == true {
            vc.navigationController?.navigationBar.isTranslucent = true
            vc.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        } else {
            vc.navigationController?.navigationBar.isTranslucent = false
            vc.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            vc.navigationController?.navigationBar.shadowImage = nil
        }
    }
}
