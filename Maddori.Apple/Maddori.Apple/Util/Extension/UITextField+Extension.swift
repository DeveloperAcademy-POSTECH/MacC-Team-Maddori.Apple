//
//  UITextField+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/18.
//

import UIKit

extension UITextField {
    func setLeftPadding() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 18, height: self.frame.height)))
        self.leftView = view
        self.leftViewMode = .always
    }
}
