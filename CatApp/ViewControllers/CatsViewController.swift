//
//  CatsViewController.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class CatsViewController: UIViewController {
    
    let cellIdentifier = String(describing: CatInformationCell.self)
    var dataSource: [CatsModel] = []
    let defaultCatsCount = 15

    var catsInfo = NetworkService()
    @IBOutlet var catsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegistration(nameCell: cellIdentifier, nibName: cellIdentifier)

        //Progress show
        catsInfo.getDataJSON(limit: defaultCatsCount) { result in
            //Progress hide
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(cats):
                    self?.dataSource = cats
                    self?.catsTableView.reloadData()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
    
    private func cellRegistration(nameCell: String, nibName: String) {
        let nibName = UINib(nibName: nibName, bundle: nil)
        catsTableView.register(nibName, forCellReuseIdentifier: nameCell)
    }

    deinit {
        print("CatsViewController:deinit")
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate 
extension CatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = catsTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CatInformationCell else { return UITableViewCell() }
        cell.model = dataSource[indexPath.row]
        return cell
    }
}

extension CatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {

        if indexPath.row == dataSource.count - 1 {
            let page = dataSource.count / defaultCatsCount

            print(page)

            catsInfo.getDataJSON(page: page, limit: defaultCatsCount) { [weak self] result in
                switch result {
                case let .success(cats):
                    self?.dataSource.append(contentsOf: cats)
                    self?.catsTableView.reloadData()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
}
