//
//  AlertHepler.swift
//  Bump
//
//  Created by Boshi Li on 29/05/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

// MARK: - 需要Alert的VC，遵從此Protocol
protocol AlertShowable: AnyObject { }

extension AlertShowable where Self: UIViewController{
    
    func alert(title: String?, message: String, style: UIAlertControllerStyle, actions: UIAlertAction?...) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions where action != nil {
            alertController.addAction(action!)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func confirmAlert(title: String, message: String, handler: (() -> Void)?) {
        let action = UIAlertAction(title: title, style: .default) { (_) in
            handler?()
        }
        self.alert(title: title, message: message, style: .alert, actions: action)
    }
        
    func showAlertWithTextField(title: String, message: String, actionATitle: String,actionAHandler: ((_ input: String)->())?, actionBTitle: String, placeHolder: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var inputText = ""
        var alertTextField = UITextField()
        
        let actionA = UIAlertAction(title: actionATitle, style: .default, handler: {
            action in
            
            inputText = alertTextField.text!
            
            if let actionAHandler = actionAHandler { actionAHandler(inputText) }
        })
        
        let actionB = UIAlertAction(title: actionBTitle, style: .default, handler: nil)
        
        alertController.addTextField()
        alertController.addAction(actionA)
        alertController.addAction(actionB)
        
        present(alertController, animated: true, completion: nil)
        
        if let textField = alertController.textFields?.first{
            
            alertTextField = textField
            alertTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.foregroundColor:UIColor.gray])
        }
    }
}
