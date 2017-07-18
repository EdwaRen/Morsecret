//
//  NewMessageController.swift
//  gameofchats
//
//  Created by Brian Voong on 6/29/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
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
        searchBar.showsCancelButton = true
        searchBar.delegate = self as! UISearchBarDelegate
        navigationItem.titleView = searchBar
        
        
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked( searchBar: UISearchBar!) {
        print("search clicked1")
        searchTextUser = searchBar.text!;

        fetchUser()

        self.view.endEditing(true)
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print("search clicked2")
        
        searchTextUser = searchBar.text!;
        
        fetchUser()
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                user.id = snapshot.key
                if (user.email == self.searchTextUser) {
                    self.users.append(user)
                }
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                    
                
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








