//
//  CatImageView.swift
//  Catinder
//
//  Created by Andrii Klykavka on 11.11.2024.
//

import UIKit
import SnapKit

class CTImageView: UIView {
    
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setupImageView()
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRounding()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        
        imageView.layer.masksToBounds   = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.centerY.equalToSuperview()
            
        }
    }
    
    private func setupShadow() {
        layer.masksToBounds = false
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset  = CGSize(width: 0, height: 5)
        layer.shadowRadius  = 5
    }
    
    private func setupRounding() {
        let radius: CGFloat = 20
        self.layer.cornerRadius = radius
        imageView.layer.cornerRadius = radius
    }
}
