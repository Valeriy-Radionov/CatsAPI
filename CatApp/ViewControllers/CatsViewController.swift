//
//  CatsViewController.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class CatsViewController: UIViewController {
    
    let cellIdentifier = "cell"
    var catsInfo = NetworkService()
    @IBOutlet var catsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegistration(nameCell: cellIdentifier, nibName: "CatInformationCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func cellRegistration(nameCell: String, nibName: String) {
        let nibName = UINib(nibName: nibName, bundle: nil)
        catsTableView.register(nibName, forCellReuseIdentifier: nameCell)
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate 
extension CatsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = catsTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CatInformationCell else { return UITableViewCell() }
        catsInfo.getDataJSON { (catsInfo) in
            DispatchQueue.main.async {
                cell.updateInterface(catInfoArray: catsInfo, indexPath: indexPath)
                self.catsTableView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
