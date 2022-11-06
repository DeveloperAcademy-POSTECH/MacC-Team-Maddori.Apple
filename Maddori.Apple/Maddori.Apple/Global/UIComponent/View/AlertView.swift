//
//  AlertView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/06.
//

import UIKit

import SnapKit

enum AlertType: String {
    case delete = "삭제하기"
    case join = "합류하기"
}

final class AlertView: UIView {
    private enum Size {
        static let alertViewWidth: CGFloat = 265
        static let alertViewHeight: CGFloat = 163
    }
    
    var title: String? {
        didSet { setupAttribute() }
    }
    
    var subTitle: String? {
        didSet { setupAttribute() }
    }
    
    var alertType: AlertType? {
        didSet { setupAttribute() }
    }
    
    
    // MARK: - property
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.layer.opacity = 0.65
        return view
    }()
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.width.equalTo(Size.alertViewWidth)
            $0.height.equalTo(Size.alertViewHeight)
            $0.center.equalTo(backgroundView.snp.center)
        }
    }
    
    // MARK: - func
    
    private func setupAttribute() {
        
    }
}
