//
//  CTButton.swift
//  Catinder
//
//  Created by Andrii Klykavka on 11.11.2024.
//

import UIKit

class CTTinderActionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: UIButton.ButtonType = .system) {
        super.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        layer.borderWidth = 5
        layer.cornerRadius = 50
        clipsToBounds = true
    }
}
