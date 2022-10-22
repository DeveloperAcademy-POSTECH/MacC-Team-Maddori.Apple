//
//  UIView+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/22.
//

import UIKit

extension UIView {
    func setGradient(colorTop: UIColor, colorBottom: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradient.locations = [0.0, 1,0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
