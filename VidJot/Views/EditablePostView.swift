//
//  EditablePostView.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/11/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class EditablePostView: UIView {
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layoutMargins.left = 20
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:20, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        return textField
    }()
    
    let entryTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 20.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.text = "\t"
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addSubview(titleTextField)
        self.addSubview(entryTextView)
        setUpEntryTextView()
        setUpTitleTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTitleTextField(){
        titleTextField.bottomAnchor.constraint(equalTo: entryTextView.topAnchor, constant: -20).isActive = true
        titleTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: entryTextView.widthAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    private func setUpEntryTextView(){
        entryTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        entryTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        entryTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        entryTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    
    
}

