//
//  LikesViweController.swift
//  Catinder
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import Combine

class LikesViewController: UIViewController {
    
    let tableView = UITableView()
    
    let viewModel: LikesViewModel
    
    init(viewModel: LikesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(LikesCell.self, forCellReuseIdentifier: LikesCell.reuseID)
        tableView.frame = view.bounds
        tableView.rowHeight = 600
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension LikesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        likedCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikesCell.reuseID) as? LikesCell else {
            return defaultCell
        }
        let cat = likedCats[indexPath.row]
        
        viewModel.fetchImage(at: cat.url) { image in
            if let image = image {
                cell.set(image: image)
            } else {
                cell.set(image: UIImage(named: "random_cat")!)
            }
        }
        return cell
    }
}
