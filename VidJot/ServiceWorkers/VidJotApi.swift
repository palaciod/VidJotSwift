//
//  VidJotApi.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/10/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation

struct VidJotApi{
    private let keyChain = KeychainSwift()
    func login(email: String, password: String, loginViewController: LoginViewController){
        let jsonUrlString = "https://safe-mesa-05056.herokuapp.com/users/login/mobile"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard let data = data else {return}
                    do{
                        let user = try JSONDecoder().decode(UserSession.self, from: data)
                        self.keyChain.set(data, forKey: "userID")
                        let mainViewController = MainViewController()
                        mainViewController.userSession = user
                        loginViewController.navigationController?.setViewControllers([mainViewController], animated: true)
                    }catch let error{
                        print(error)
                        print("Faild here")
                    }
                    
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func getIdeas(main: MainViewController,id: String){
        let jsonUrlString = "https://safe-mesa-05056.herokuapp.com/ideas/mobile/ideas/\(id)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let ideas = try JSONDecoder().decode([Idea].self, from: data)
                    main.ideaArray = ideas
                    print("<---------\(ideas)---------->")
                    print("This is the current size of the array: \(ideas.count)")
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func deleteIdea(id: String){
        DispatchQueue.main.async {
            let jsonUrlString = "https://safe-mesa-05056.herokuapp.com/ideas/mobile/delete/\(id)"
            guard let url = URL(string: jsonUrlString) else {return}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                print("Successfully deleted post.")
                
                }.resume()
        }
    }
    
    func createNewPost(id: String, title: String, ideaDetails: String){
        let jsonUrlString = "https://safe-mesa-05056.herokuapp.com/ideas/mobile/create/\(id)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["title":title,"details":ideaDetails,"user":id]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func logout(mainViewController: MainViewController){
        keyChain.delete("userID")
        URLSession.shared.reset {
            print("Successfully signout")
            DispatchQueue.main.async {
                mainViewController.navigationController?.setViewControllers([LoginViewController()], animated: true)
            }
        }
        
    }
    
    func signInStatus(loginViewController: LoginViewController){
        
        let data = keyChain.getData("userID")
        let cookies = HTTPCookieStorage.shared.cookies
        if !cookies!.isEmpty {
            do{
                print("User is signed in")
                let user = try JSONDecoder().decode(UserSession.self, from: data!)
                let mainViewController = MainViewController()
                mainViewController.userSession = user
                loginViewController.navigationController?.setViewControllers([mainViewController], animated: true)
            }catch let jsonError {
                print("Error serializing json:",jsonError)
                
            }
        }else {
            print("User is not signed in")
        }
        
        
    }
    
    func editPost(ideaID: String, title: String, ideaDetails: String){
        let jsonUrlString = "https://safe-mesa-05056.herokuapp.com/ideas/mobile/edit/\(ideaID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let params = ["title":title,"details":ideaDetails]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    func register(email: String, password: String,password2: String, name: String, loginViewController: LoginViewController){
        let jsonUrlString = "https://safe-mesa-05056.herokuapp.com/users/mobile/register"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password, "name":name, "password2":password2]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard data != nil else {return}
                    self.login(email: email.lowercased(), password: password, loginViewController: loginViewController)
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
    
}
