////
////  ViewControllerInitial.swift
////  Morsecret
////
////  Created by - on 2017/07/28.
////  Copyright © 2017 Secretapp. All rights reserved.
////
//
//import UIKit
//
//class ViewControllerInitial: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        // Create Tab one
//        let tabOne = MessagesController()
//        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
//        
//        tabOne.tabBarItem = tabOneBarItem
//        
//        
//        // Create Tab two
//        let tabTwo = LoginController()
//        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
//        
//        tabTwo.tabBarItem = tabTwoBarItem2
//        
//        
////        self.childViewControllers = [tabOne, tabTwo]
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
