//
//  Extensions.swift
//  gameofchats
//
//  Created by Edward Ren on 7/5/16.
//  Copyright © 2016 Secretapp. All rights reserved.
//


import UIKit


class AlertHelper {
    func showAlert(fromController controller: UIViewController) {
        var alert = UIAlertController(title: "abc", message: "def", preferredStyle: .alert)
        controller.present(alert, animated: true, completion: nil)
    }
}
