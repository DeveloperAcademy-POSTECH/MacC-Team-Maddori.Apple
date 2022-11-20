//
//  UITableview + Extension.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/20.
//

import UIKit

extension UITableView {
    func setEmptyFeedbackView() {
        let emptyView = EmptyFeedbackView()
        emptyView.sizeToFit()
        emptyView.emptyFeedbackLabel.text = "팀원에게 받은 피드백이 없습니다"
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

