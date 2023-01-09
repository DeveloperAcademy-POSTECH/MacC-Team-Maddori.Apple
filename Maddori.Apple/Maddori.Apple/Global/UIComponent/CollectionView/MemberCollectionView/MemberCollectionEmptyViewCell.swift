//
//  MemberCollectionEmptyViewCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/01/09.
//

import UIKit

import SnapKit

final class MemberCollectionEmptyViewCell: BaseCollectionViewCell {
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func render() {
        self.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(179)
            $0.height.equalTo(121)
        }
    }
}
