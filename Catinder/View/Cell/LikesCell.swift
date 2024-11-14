//
//  LikesCell.swift
//  Catinder
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import SnapKit

class LikesCell: UITableViewCell {
    
    static let reuseID = "LikesCell"
    
    let breedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage) {
        breedImageView.image = image
    }
    
    private func setupView() {
        addSubview(breedImageView)
    }
    
    private func setupLayout() {
        breedImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}
