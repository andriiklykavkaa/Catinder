//
//  LoaderPartialBorderView.swift
//  Catinder
//
//  Created by Andrii Klykavka on 11.11.2024.
//

import UIKit

class LoaderPartialBorderView: UIView {

    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPartialGradientBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPartialGradientBorder() {
        let circularPath = UIBezierPath(ovalIn: bounds.insetBy(dx: 5, dy: 5))
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.strokeEnd = 0.75
        layer.addSublayer(shapeLayer)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = bounds
        shapeLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: 5, dy: 5)).cgPath
    }
}
