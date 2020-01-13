//
//  IdeaCell.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/10/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class IdeaCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title?"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let ideaDetails: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Idea"
        //xsschool.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    private let blankSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        button.setTitle("DELETE", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(titleLabel)
        self.addSubview(ideaDetails)
        self.addSubview(editButton)
        self.addSubview(blankSpace)
        self.addSubview(deleteButton)
        setTitleLabel()
        setUpIdeaDetails()
        setUpEditButton()
        setUpBlankSpace()
        setUpDeleteButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel(){
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setUpIdeaDetails(){
        ideaDetails.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        ideaDetails.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ideaDetails.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        ideaDetails.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        ideaDetails.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func setUpEditButton(){
        editButton.topAnchor.constraint(equalTo: ideaDetails.bottomAnchor).isActive = true
        editButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        editButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.09).isActive = true
    }
    
    private func setUpBlankSpace(){
        blankSpace.topAnchor.constraint(equalTo: editButton.bottomAnchor).isActive = true
        blankSpace.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
    }
    
    private func setUpDeleteButton(){
        deleteButton.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.09).isActive = true
    }
}
