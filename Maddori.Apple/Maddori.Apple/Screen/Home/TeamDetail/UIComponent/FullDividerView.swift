//
//  FullDividerView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/07.
//

import UIKit

import SnapKit

final class FullDividerView: UIView {
    
    // MARK: - property
    
//    let dividerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .gray300
//        return view
//    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray300
//        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
//    private func render() {
//        self.addSubview(dividerView)
//        dividerView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.height.equalTo(4)
//        }
//    }
}
