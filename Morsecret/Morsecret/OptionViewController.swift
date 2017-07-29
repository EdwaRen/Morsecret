//
//  OptionViewController.swift
//  Morsecret
//
//  Created by - on 2017/07/28.
//  Copyright © 2017 Secretapp. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {
    
    let myView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleChangeOptions : UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
//        myLabel.font = UIFont(name: "Raleway-Regular", size: 18)
        myLabel.text = "Changing Options"
        myLabel.textColor = UIColor.black;
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0;
        myLabel.font = UIFont(name: "Raleway-Bold", size: 18)
        
        return myLabel
    }()
    
    let descChangeOptions : UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        myLabel.text = "Select a person to message from the home screen, then click the top right to change messaging options such as volume button input."
        myLabel.textColor = UIColor.black;
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0;
        myLabel.font = UIFont(name: "Raleway-Regular", size: 12)
        
        return myLabel
    }()
    
    let titleVolumeButton : UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        myLabel.text = "Volume Button Input"
        myLabel.textColor = UIColor.black;
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0;
        myLabel.font = UIFont(name: "Raleway-Bold", size: 18)
        
        return myLabel
    }()
    
    let labelVolumeButton : UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "When this is enabled, click the up volume button to send a dot in morse code (.) which will appear in the messaging text box. Otherwise, click the down volume button to send a dash in morse code (-). Enabling this will also display the keyboard. IMPORTANT please leave 1.5 seconds after each alphabetical letter you type in so that the program will recognize a letter change and create a new letter in that location."
        myLabel.textColor = UIColor.black;
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0;
        myLabel.font = UIFont(name: "Raleway-Regular", size: 12)
        
        return myLabel
    }()
    
    let titleAutoVibrate : UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "Auto Vibrate"
        myLabel.textColor = UIColor.black;
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0;
        myLabel.font = UIFont(name: "Raleway-Bold", size: 18)
        return myLabel
    }()
    
    let labelAutoVibrate : UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "When this is enabled, any incoming alphabetical messages are automatically translated and vibrated into morse code. If the message itself is morse code, then it will directly vibrate them. \n\nFor more detailed instructions, visit www.github.com/edwaren/morsecret and see the readme file."
        myLabel.textColor = UIColor.black;
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0;
        myLabel.font = UIFont(name: "Raleway-Regular", size: 12)
        return myLabel
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white;
        
        view.addSubview(titleChangeOptions);
        view.addSubview(descChangeOptions);
        view.addSubview(titleVolumeButton);
        view.addSubview(labelVolumeButton);
        view.addSubview(titleAutoVibrate);
        view.addSubview(labelAutoVibrate);
        view.addSubview(myView);
        
        createTextLabels();
        navigationController?.title = "Help";
        let defaults = UserDefaults.standard
        defaults.set("1", forKey: "info")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let titleSize = 15.0;
    let labelSize = 12.0;
    
   
    
    func createTextLabels() {
        
        let titleConstant:CGFloat = 10;
        let labelConstant:CGFloat = 10;

        titleChangeOptions.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true;
        titleChangeOptions.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        titleChangeOptions.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        titleChangeOptions.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        descChangeOptions.topAnchor.constraint(equalTo: titleChangeOptions.bottomAnchor, constant: labelConstant-10).isActive = true;
        descChangeOptions.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        descChangeOptions.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        descChangeOptions.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        titleVolumeButton.topAnchor.constraint(equalTo: descChangeOptions.bottomAnchor, constant: titleConstant).isActive = true;
        titleVolumeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        titleVolumeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        titleVolumeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true;

        labelVolumeButton.topAnchor.constraint(equalTo: titleVolumeButton.bottomAnchor, constant: labelConstant).isActive = true;
        labelVolumeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        labelVolumeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        labelVolumeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        titleAutoVibrate.topAnchor.constraint(equalTo: labelVolumeButton.bottomAnchor, constant: titleConstant).isActive = true;
        titleAutoVibrate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        titleAutoVibrate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        titleAutoVibrate.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        labelAutoVibrate.topAnchor.constraint(equalTo: titleAutoVibrate.bottomAnchor, constant: labelConstant).isActive = true;
        labelAutoVibrate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        labelAutoVibrate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        labelAutoVibrate.heightAnchor.constraint(equalToConstant: 60).isActive = true;

        



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
