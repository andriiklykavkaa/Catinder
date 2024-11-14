//
//  ViewController.swift
//  Catinder
//
//  Created by Roman Mishchenko on 30.10.2024.
//

import UIKit
import Combine
import SnapKit

class HomeViewController: UIViewController {
    
    let imageView = CTImageView()
    let buttonStackView = CTButtonStackView()
    let loader = CTLoaderViewController()
    
    var cancellables: Set<AnyCancellable> = []
    
    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.fetchCat()
        setupView()
        configureBindings()
        setupLayout()
        addSwipeGestures()
    }
    
    private func setupView() {
        view.addSubview(imageView)
        imageView.setImage(UIImage(named: "cat-placeholder")!)
        imageView.backgroundColor = .systemBackground
        
        view.addSubview(buttonStackView)
        buttonStackView.delegate = self
    }
    
    private func configureBindings() {
        viewModel.$isCatLoading
            .subscribe(on: DispatchQueue.main)
            .sink { _ in
                    print("Loading is completed!")
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case true:
                    self.present(self.loader, animated: true)
                    guard let cat = viewModel.cat else {
                        self.loader.dismiss(animated: true)
                        return
                    }
                    viewModel.fetchImage(at: cat.url) { image in
                        guard let image = image else { return }
                        self.imageView.setImage(image)
                    }
                    
                case false:
                    DispatchQueue.main.async {
                        self.loader.dismiss(animated: true)
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.$cat
            .subscribe(on: DispatchQueue.main)
            .sink { cat in
                if let cat = cat {
                    likedCats.append(cat)
                    print("A cat added: \(likedCats.count)")
                }
            }
            .store(in: &cancellables)
    }
    
    func addSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipe.direction = .left
        imageView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipe.direction = .right
        imageView.addGestureRecognizer(rightSwipe)
    }
    
    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            viewModel.fetchCat()
            print("Liked a cat SW")
        case .left:
            viewModel.fetchCat()
            print("Disliked cat SW")
        default:
            break
        }
    }

    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(550)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.height.equalTo(100)
        }
    }
}

extension HomeViewController: CTButtonStackViewDelegate {
    func acceptCat() {
        viewModel.fetchCat()
    }
    
    func denyCat() {
        print("Disliked cat")
        viewModel.fetchCat()
    }
}
