//
//  CatsVC.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class CatsVC: UIViewController {
    
    let cellIdentifier = "cell"
    @IBOutlet var catsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegistration(nameCell: cellIdentifier, nibName: "CatInformationCell")
    }
    
    private func cellRegistration(nameCell: String, nibName: String) {
        let nibName = UINib(nibName: nibName, bundle: nil)
        catsTableView.register(nibName, forCellReuseIdentifier: nameCell)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate 
extension CatsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
