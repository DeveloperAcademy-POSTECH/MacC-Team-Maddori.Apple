//
//  UICollectionView + Extension.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/06.
//

import UIKit

extension UICollectionView {
    func setEmptyReflectionView() {
        let emptyView = EmptyReflectionView()
        emptyView.sizeToFit()
        self.backgroundView = emptyView
    }
    
    func setEmptyFeedbackView(with label: String) {
        let emptyView = EmptyFeedbackView()
        emptyView.emptyFeedbackLabel.text = label
        emptyView.sizeToFit()
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
