//
//  RegisterViewController.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/12/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    private let navBar: NavBar = {
        let navbar = NavBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.leftButton.setTitle("Back", for: .normal)
        navbar.rightButton.setTitle("", for: .normal)
        return navbar
    }()
    
    private let regisetInputView: RegisterInputView = {
        let inputFields = RegisterInputView()
        inputFields.translatesAutoresizingMaskIntoConstraints = false
        return inputFields
    }()
    private let blankSpace = UIView()
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    private let vidJotApi: VidJotApi = {
        let api = VidJotApi()
        return api
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBar)
        view.addSubview(regisetInputView)
        view.addSubview(registerButton)
        setUpNavBar()
        createBlankSpace(blankSpace: blankSpace, y: regisetInputView.bottomAnchor)
        setUpRegisterView()
        setUpRegisterButton()
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.leftButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    private func setUpRegisterView(){
        regisetInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        regisetInputView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        regisetInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        regisetInputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
    private func createBlankSpace(blankSpace: UIView, y: NSLayoutYAxisAnchor){
        blankSpace.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blankSpace)
        blankSpace.topAnchor.constraint(equalTo: y).isActive = true
        blankSpace.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
    }
    
    private func setUpRegisterButton(){
        registerButton.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: regisetInputView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    private func checkFields() -> Bool {
        let nameString = regisetInputView.nameTextField.text ?? ""
        let emailString = regisetInputView.emailTextField.text ?? ""
        let passwordString = regisetInputView.passwordTextField.text ?? ""
        let secondPasswordString = regisetInputView.secondPasswordTextField.text ?? ""
        if nameString.isEmpty || emailString.isEmpty || passwordString.isEmpty || secondPasswordString.isEmpty {
            return false
        }
        return true
    }
    
    private func doPasswordsMatch() -> Bool {
        let passwordString = regisetInputView.passwordTextField.text ?? ""
        let secondPasswordString = regisetInputView.secondPasswordTextField.text ?? ""
        if passwordString == secondPasswordString {
            return true
        }
        return false
    }
    
    @objc private func back(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func register(){
        let nameString = regisetInputView.nameTextField.text ?? ""
        let emailString = regisetInputView.emailTextField.text ?? ""
        let passwordString = regisetInputView.passwordTextField.text ?? ""
        let secondPasswordString = regisetInputView.secondPasswordTextField.text ?? ""
        let login = navigationController?.viewControllers[0] as! LoginViewController
        if checkFields() {
            if doPasswordsMatch() {
                vidJotApi.register(email: emailString.lowercased(), password: passwordString, password2: secondPasswordString, name: nameString, loginViewController: login)
            }else{
                print("Passwords do not match")
            }
        }else{
            print("Fill in the required fields")
        }
    }
}
