//
//  BreedCell.swift
//  Catinder
//
//  Created by Andrii Klykavka on 12.11.2024.
//

import UIKit
import SnapKit

class BreedCell: UITableViewCell {
    
    static let reuseID = "BreedCell"
    
    let breedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .label
        label.minimumScaleFactor = 0.9
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemYellow
        label.minimumScaleFactor = 0.9
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let temperamentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.minimumScaleFactor = 0.75
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with breed: Breed, image: UIImage) {
        breedImageView.image = image
        nameLabel.text = breed.name
        originLabel.text = breed.origin
        temperamentLabel.text = breed.temperament
    }
    
    private func setupView() {
        let views: [UIView] = [breedImageView, nameLabel, originLabel, temperamentLabel]
        views.forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        breedImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(breedImageView)
            $0.leading.equalTo(breedImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(24)
        }
        
        originLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }
        
        temperamentLabel.snp.makeConstraints {
            $0.top.equalTo(originLabel.snp.bottom).offset(2)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
