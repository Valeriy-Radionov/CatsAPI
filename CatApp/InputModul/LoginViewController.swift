//
//  LoginViewController.swift
//  CatApp
//
//  Created by Valera on 9/18/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: UIButton) {
        navigationController?.pushViewController(ModulBuilder.createMainModule(), animated: true)
    }
}
