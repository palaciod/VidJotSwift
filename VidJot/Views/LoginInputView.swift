//
//  LoginInputView.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/10/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class LoginInputView: UIView {
    
     let loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Email"
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
     let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Password"
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(loginTextField)
        self.addSubview(passwordTextField)
        setUpLogin()
        setUpPassword()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLogin(){
        loginTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loginTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        loginTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setUpPassword(){
        passwordTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
}
