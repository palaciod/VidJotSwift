//
//  NewIdeaViewController.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/11/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class NewIdeaViewController: UIViewController {
    var userSession: UserSession?
    var ideas: [Idea]?
    var targetMethod: String?
    var index: Int?
    private let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.787992936, alpha: 1)
        navBar.leftButton.setTitle("Canel", for: .normal)
        navBar.rightButton.setTitle("Add", for: .normal)
        return navBar
    }()
    private let idea: EditablePostView = {
        let post = EditablePostView()
        post.translatesAutoresizingMaskIntoConstraints = false
        return post
    }()
    private let api = VidJotApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBar)
        view.addSubview(idea)
        setUpNavBar()
        setUpIdea()
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.rightButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        navBar.leftButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    private func setUpIdea(){
        idea.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        idea.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        idea.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    @objc private func cancel(){
        print("Cancel")
        let mainViewController = MainViewController()
        mainViewController.userSession = userSession
        mainViewController.ideaArray = ideas
        self.navigationController?.setViewControllers([mainViewController], animated: true)
    }
    @objc private func add(){
        let title = idea.titleTextField.text ?? ""
        let details = idea.entryTextView.text ?? ""
        let userID = userSession!.passport.user
        if targetMethod! == "post" {
            api.createNewPost(id: userID, title: title, ideaDetails: details)
            print("post")
        }else{
            print("edit")
            let ideaID = ideas?[index!]._id ?? "404"
            api.editPost(ideaID: ideaID, title: title, ideaDetails: details)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let mainViewController = MainViewController()
            mainViewController.userSession = self.userSession
            mainViewController.ideaArray = self.ideas
            self.navigationController?.setViewControllers([mainViewController], animated: true)
        }
    }

}
