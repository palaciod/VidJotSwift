//
//  LoginViewController.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/10/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginTextView: LoginInputView = {
        let textFields = LoginInputView()
        textFields.translatesAutoresizingMaskIntoConstraints = false
        return textFields
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    private let blankSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register here", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let vidJotApi: VidJotApi = {
        let api = VidJotApi()
        return api
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vidJotApi.signInStatus(loginViewController: self)
        view.addSubview(loginTextView)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(blankSpace)
        setUpLoginView()
        setUpLoginButton()
        setUpBlankSpace()
        setUpRegisterButton()
    }
    
    private func setUpLoginView(){
        loginTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        loginTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }
    private func setUpLoginButton(){
        loginButton.topAnchor.constraint(equalTo: loginTextView.bottomAnchor, constant: 30).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginTextView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        // Adding target
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
    }
    private func setUpBlankSpace(){
        blankSpace.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blankSpace.topAnchor.constraint(equalTo: loginButton.bottomAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30).isActive = true
    }
    private func setUpRegisterButton(){
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
        // Adding target
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    @objc private func login(){
        print("Login")
        let emailString = loginTextView.loginTextField.text?.lowercased() ?? ""
        print(emailString)
        let passwordString = loginTextView.passwordTextField.text ?? ""
        print(passwordString)
        vidJotApi.login(email: emailString, password: passwordString, loginViewController: self)
    }
    
    
    @objc private func register(){
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }

}
