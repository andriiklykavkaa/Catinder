//
//  CTSpinner.swift
//  Catinder
//
//  Created by Andrii Klykavka on 11.11.2024.
//

import UIKit
import SnapKit

class CTLoaderViewController: UIViewController {
    
    let loaderView = LoaderPartialBorderView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        setupLoaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
    
    private func startAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1
        rotation.repeatCount = .infinity
        loaderView.layer.add(rotation, forKey: "spin")
    }
    
    private func stopAnimation() {
        loaderView.layer.removeAnimation(forKey: "spin")
    }
    
    private func setupLoaderView() {
        
        view.addSubview(loaderView)
        loaderView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
