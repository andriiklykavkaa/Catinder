//
//  CTAcceptButton.swift
//  Catinder
//
//  Created by Andrii Klykavka on 11.11.2024.
//

import UIKit

class CTAcceptButton: CTTinderActionButton {
    override init(type: UIButton.ButtonType = .system) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let image = UIImage(systemName: "heart.fill")
        setImage(image, for: .normal)
        layer.borderColor = UIColor.systemGreen.cgColor
        tintColor = .systemGreen
        titleLabel?.font = UIFont.systemFont(ofSize: 21)

    }
}
