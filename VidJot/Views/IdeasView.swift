//
//  IdeasView.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/10/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class IdeasView: UIView {
    var ideas: [Idea]?
    var navigator: UINavigationController?
    var userSession: UserSession?
    let recycler: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let recycler = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recycler.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        recycler.translatesAutoresizingMaskIntoConstraints = false
        recycler.register(IdeaCell.self, forCellWithReuseIdentifier: "cellID")
        return recycler
    }()
    
    private let vidJotApi: VidJotApi = {
        let api = VidJotApi()
        return api
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(recycler)
        setUpRecycler()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpRecycler(){
        recycler.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        recycler.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        recycler.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        recycler.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        recycler.delegate = self
        recycler.dataSource = self
        
    }

}

extension IdeasView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: recycler.frame.width * 0.9, height: recycler.frame.height * 0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let ideasCount = ideas?.count ?? 0
        print(ideasCount)
        return ideasCount
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recycler.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! IdeaCell
        
        setUpCellDimensions(cell: cell)
        
        let index = indexPath[1]
        
        let title = ideas?[index].title ?? ""
        
        let idea = ideas?[index].details ?? ""
        
        let deleteButton = cell.deleteButton
        let editButton = cell.editButton
        setTitle(title: title, cell: cell)
        setIdea(idea: idea, cell: cell)
        deleteButtonTarget(button: deleteButton, index: index)
        editButtonTarget(button: editButton, index: index)
        return cell
    }
    
    private func setUpCellDimensions(cell: IdeaCell){
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
    }
    
    private func setTitle(title: String, cell: IdeaCell){
        cell.titleLabel.text = title
    }
    
    private func setIdea(idea: String, cell: IdeaCell){
        cell.ideaDetails.text = idea
    }
    
    private func deleteButtonTarget(button: UIButton, index: Int){
        button.tag = index
        button.addTarget(self, action: #selector(deleteIdea), for: .touchUpInside)
    }
    
    private func editButtonTarget(button: UIButton, index: Int){
        button.tag = index
        button.addTarget(self, action: #selector(editIdea), for: .touchUpInside)
    }
    @objc private func deleteIdea(sender: UIButton){
        let index = sender.tag
        let indexPath: [IndexPath] = [[0,index]]
        let ideaID = ideas?[index]._id ?? "404"
        vidJotApi.deleteIdea(id: ideaID)
        ideas?.remove(at: index)
        recycler.deleteItems(at: indexPath)
        updateButtonTags()
    }
    @objc private func editIdea(sender: UIButton){
        print("Edit")
        let index = sender.tag
        let editIdeaViewController = NewIdeaViewController()
        editIdeaViewController.userSession = userSession
        editIdeaViewController.ideas = ideas
        editIdeaViewController.targetMethod = "edit"
        editIdeaViewController.index = index
        recycler.delegate = nil
        recycler.dataSource = nil
        navigator?.setViewControllers([editIdeaViewController], animated: true)
        
    }
    
    private func updateButtonTags(){
        var count = ideas!.count - 1
        for cell in recycler.visibleCells{
            let ideaCell = cell as! IdeaCell
            ideaCell.deleteButton.tag = count
            count -= 1
        }
    }
}
