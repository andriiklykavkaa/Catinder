//
//  CTButtonStackView.swift
//  Catinder
//
//  Created by Andrii Klykavka on 11.11.2024.
//

import UIKit
import SnapKit

protocol CTButtonStackViewDelegate: AnyObject {
    func acceptCat()
    func denyCat()
}

class CTButtonStackView: UIStackView {
    
    let acceptButton = CTAcceptButton()
    let denyButton = CTDenyButton()
    
    weak var delegate: CTButtonStackViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        
        addArrangedSubview(denyButton)
        addArrangedSubview(acceptButton)
        
        denyButton.addTarget(self, action: #selector(denyCat), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(acceptCat), for: .touchUpInside)
        
        acceptButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        denyButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
    
    @objc private func acceptCat() { delegate?.acceptCat() }
    
    @objc private func denyCat() { delegate?.denyCat() }
    
}
