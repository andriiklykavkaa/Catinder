//
//  BreedViewController.swift
//  Catinder
//
//  Created by Andrii Klykavka on 12.11.2024.
//

import UIKit
import Combine

class BreedViewController: UIViewController {
    
    let tableView = UITableView()
    let loader = CTLoaderViewController()
    
    var cancellables: Set<AnyCancellable> = []
    
    let viewModel: BreedViewModel
    
    init(viewModel: BreedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupBindings()
        viewModel.fetchBreeds()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseID)
        tableView.frame = view.bounds
        tableView.rowHeight = 120
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupBindings() {
        viewModel.$breeds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isBreedsLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                switch value {
                case true:
                    self.present(self.loader, animated: true)
                case false:
                    self.loader.dismiss(animated: true)
                }
            }
            .store(in: &cancellables)
    }
}

extension BreedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseID) as? BreedCell else {
            return defaultCell
        }
        let breed = viewModel.breeds[indexPath.row]
        guard let imageURLWrapper = breed.image, let imageURL = imageURLWrapper.url else {
            return defaultCell
        }
        
        viewModel.fetchImage(at: imageURL) { image in
            if let image = image {
                cell.set(with: breed, image: image)
            } else {
                cell.set(with: breed, image: UIImage(named: "cat-placeholder")!)
            }
        }
        return cell
    }
}
