//
//  ChatOptionsController.swift
//  Morsecret
//
//  Created by - on 2017/07/21.
//  Copyright © 2017 Secretapp. All rights reserved.
//

import UIKit



class ChatOptionsController: UIViewController {
    var user: User?
    let keyboardButton = UIButton(type: .system)

    let volumeButton = UIButton(type: .system)
    var currentMode: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.title = "Options"
        
        if (currentMode == 0) {
            keyboardButtonPress()
        } else if (currentMode == 1) {
            volumeButtonPress()
        }
        
        setUpItems()
        
    }
    
   
    
    func keyboardButtonPress() {
        let defaults = UserDefaults.standard
        defaults.set("0", forKey: "input")
        keyboardButton.setTitleColor(UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0), for: .normal)
        keyboardButton.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
        
        volumeButton.setTitleColor(UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0), for: .normal)
        volumeButton.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
    }
    func volumeButtonPress() {
        let defaults = UserDefaults.standard
        defaults.set("1", forKey: "input")
        
        volumeButton.setTitleColor(UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0), for: .normal)
        volumeButton.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
        
        keyboardButton.setTitleColor(UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0), for: .normal)
        keyboardButton.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
    }
    func liveVibrationPress() {
        
    }
    

    
    func setUpItems() {
        print("Setting up userinfo")
        
        let nameLabel: UILabel = {
            let name = UILabel()
            name.text = user?.name
            name.translatesAutoresizingMaskIntoConstraints = false
            return name
        }()
        
        let profileImage: UIImageView = {
            let myImage = UIImageView()
            myImage.translatesAutoresizingMaskIntoConstraints = false
            myImage.contentMode = .scaleAspectFill
            myImage.layer.cornerRadius = 20
//            myImage.clipsToBounds = true
            return myImage
        }()
        if let profileImageUrl = user?.profileImageUrl {
            profileImage.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        view.addSubview(profileImage)
        view.addSubview(nameLabel)

        
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 64).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 6).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        
        view.addSubview(keyboardButton)
        view.addSubview(volumeButton)
        
        keyboardButton.translatesAutoresizingMaskIntoConstraints = false
        keyboardButton.setTitle("     KEYBOARD", for: .normal)
        keyboardButton.contentHorizontalAlignment = .left
        keyboardButton.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 21)
        keyboardButton.setTitleColor(UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0), for: .normal)
        keyboardButton.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        keyboardButton.addTarget(self, action: #selector(keyboardButtonPress), for: .touchUpInside)
        
        
        keyboardButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        keyboardButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 75).isActive = true
        keyboardButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 1).isActive = true
        keyboardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1).isActive = true
        keyboardButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        volumeButton.translatesAutoresizingMaskIntoConstraints = false
        volumeButton.setTitle("     VOLUME BUTTONS", for: .normal)
        volumeButton.contentHorizontalAlignment = .left
        volumeButton.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 21)
        volumeButton.setTitleColor(UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0), for: .normal)
        volumeButton.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        volumeButton.addTarget(self, action: #selector(volumeButtonPress), for: .touchUpInside)
        
        
        volumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        volumeButton.topAnchor.constraint(equalTo: keyboardButton.bottomAnchor, constant: 4).isActive = true
        volumeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 1).isActive = true
        volumeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 1).isActive = true
        volumeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        

        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


