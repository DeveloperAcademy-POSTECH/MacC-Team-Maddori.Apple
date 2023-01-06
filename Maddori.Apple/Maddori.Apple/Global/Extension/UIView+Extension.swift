//
//  UIView+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/22.
//

import UIKit

extension UIView {
    
    enum GradientDirection {
        case positiveX
        case negativeX
        case positiveY
        case negativeY
    }
    
    func setGradient(colorTop: UIColor, colorBottom: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradient.locations = [0.0, 1,0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    func setBlurGradient(in direction: GradientDirection, by portion: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.backgroundWhite.withAlphaComponent(0).cgColor,
            UIColor.backgroundWhite.withAlphaComponent(1).cgColor
        ]
        let viewEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: viewEffect)
        switch direction {
        case .positiveX:
            effectView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width * portion, height: self.bounds.size.height)
            effectView.autoresizingMask = [.flexibleWidth]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .negativeX:
            effectView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width * portion, height: self.bounds.size.height)
            effectView.autoresizingMask = [.flexibleWidth]
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        case .positiveY:
            effectView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height * portion)
            effectView.autoresizingMask = [.flexibleHeight]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .negativeY:
            effectView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height * portion)
            effectView.autoresizingMask = [.flexibleHeight]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        }
        gradientLayer.frame = effectView.frame
        effectView.layer.mask = gradientLayer
        effectView.isUserInteractionEnabled = false
        addSubview(effectView)
    }
    
    func setFadingMask() {
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = self.bounds
        gradientMaskLayer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor,
        ]
        self.layer.mask = gradientMaskLayer
    }
    
    @discardableResult
    func makeShadow(color: UIColor,
                    opacity: Float,
                    offset: CGSize,
                    radius: CGFloat) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        return self
    }
}
