//
//  CTDenyButton.swift
//  Catinder
//
//  Created by Andrii Klykavka on 11.11.2024.
//

import UIKit

class CTDenyButton: CTTinderActionButton {
    override init(type: UIButton.ButtonType = .system) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let image = UIImage(systemName: "xmark")
        setImage(image, for: .normal)
        layer.borderColor = UIColor.systemRed.cgColor
        tintColor = .systemRed
        titleLabel?.font = UIFont.systemFont(ofSize: 72)
    }
}
