//
//  ViewController.swift
//  LoadingAlertExample
//
//  Created by Brandon Erbschloe on 1/10/20.
//  Copyright © 2020 Brandon Erbschloe. All rights reserved.
//

import UIKit
import LoadingAlert

class ViewController: UIViewController {

    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("Show Dialog", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showDialog), for: .primaryActionTriggered)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        ])
    }

    @objc func showDialog() {
        presentLoadingAlertModal(animated: true, completion: nil)
        presentLoadingAlertModal(animated: true, completion: nil)
        presentLoadingAlertModal(animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.dismissLoadingAlertModal(animated: true) { print("here") }
            self.dismissLoadingAlertModal(animated: true) { print("here") }
            self.dismissLoadingAlertModal(animated: true) { print("here") }
            self.dismissLoadingAlertModal(animated: true) { print("here") }
            self.dismissLoadingAlertModal(animated: true) { print("here") }
        }
    }
}
