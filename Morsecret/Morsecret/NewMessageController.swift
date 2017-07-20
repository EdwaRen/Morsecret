//
//  MorseTranslate.swift
//  Morsecret
//
//  Created by Edward Ren on 2017/07/18.
//  Copyright © 2017 Secretapp. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController, UISearchBarDelegate {
    
    let cellId = "cellId"
    
    var users = [User]()
    
    lazy var searchBar:UISearchBar = UISearchBar();
    var searchTextUser:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        searchBar.placeholder = "Search Users"

        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -30)
//        searchBar.showsCancelButton = true
        searchBar.delegate = self as! UISearchBarDelegate
        navigationItem.titleView = searchBar
        
        
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    // called when search button is clicked
//    func searchBarSearchButtonClicked( searchBar: UISearchBar!) {
//        print("search clicked1")
//        searchTextUser = searchBar.text!;
//
//        fetchUser()
//
//        self.view.endEditing(true)
//    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print("search clicked2")
        self.users.removeAll()

        searchTextUser = searchBar.text!;
        
        fetchUser()
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                user.id = snapshot.key
                
                do {
                    var appended = false
                    if (self.searchTextUser.characters.count <= (user.email?.characters.count)!){

                        let indexEmail = try user.email?.index((user.email?.startIndex)!, offsetBy: self.searchTextUser.characters.count)
                        if user.email?.substring(to: indexEmail!) == self.searchTextUser  && self.searchTextUser.characters.count > 1  {
                            appended = true
                            self.users.append(user)
                        }
                    }
                    if (self.searchTextUser.characters.count <= (user.name?.characters.count)! && appended == false){
                        let indexName = try user.name?.index((user.name?.startIndex)!, offsetBy: self.searchTextUser.characters.count)
                        if (user.name?.substring(to: indexName!) == self.searchTextUser) && self.searchTextUser.characters.count > 1  {
                            print(user.name?.characters, " should be printing user name")
                            self.users.append(user)
                        }
                    }
                
                    
                    //this will crash because of background thread, so lets use dispatch_async to fix
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                } catch {
                    print("something went wrong")
                }
                
                
                //                user.name = dictionary["name"]
            }
            
        }, withCancel: nil)
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var messagesController: MessagesController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("Dismiss completed")
            let user = self.users[indexPath.row]
            self.messagesController?.showChatControllerForUser(user)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
}








