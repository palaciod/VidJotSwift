//
//  MainViewController.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/10/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var userSession: UserSession?
    var ideaArray: [Idea]?
    private let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.787992936, alpha: 1)
        navBar.leftButton.setTitle("Logout", for: .normal)
        navBar.rightButton.setTitle("Add", for: .normal)
        return navBar
    }()
    private let ideas: IdeasView = {
        let ideas = IdeasView()
        ideas.translatesAutoresizingMaskIntoConstraints = false
        return ideas
    }()
    private let blankSpace: UIView = {
        let space = UIView()
        space.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    private let vidJotApi: VidJotApi = {
        let api = VidJotApi()
        return api
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllIdeas()
        view.addSubview(navBar)
        setUpNavBar()
        addIdeaView()
        
    }
    
    private func getAllIdeas(){
        let userID = userSession?.passport.user ?? ""
        print("This is the id: \(userID)")
        vidJotApi.getIdeas(main: self, id: userID)
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.rightButton.addTarget(self, action: #selector(toNewPost), for: .touchUpInside)
        navBar.leftButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    
    private func addIdeaView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.addSubview(self.ideas)
            self.ideas.ideas = self.ideaArray
            self.setUpIdeasView()
        }
    }
    
    
    private func setUpIdeasView(){
        ideas.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        ideas.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        ideas.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ideas.userSession = userSession
        ideas.navigator = navigationController
    }
    
    @objc private func toNewPost(){
        ideas.recycler.delegate = nil
        ideas.recycler.dataSource = nil
        let newIdeaViewController = NewIdeaViewController()
        newIdeaViewController.userSession = userSession
        newIdeaViewController.ideas = ideaArray
        newIdeaViewController.targetMethod = "post"
        navigationController?.setViewControllers([newIdeaViewController], animated: true)
    }
    
    @objc private func logout(){
        vidJotApi.logout(mainViewController: self)
    }

}
