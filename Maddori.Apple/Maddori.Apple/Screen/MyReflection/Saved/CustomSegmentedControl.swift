//
//  SegmentedControl.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import SnapKit

class CustomSegmentedControl: UISegmentedControl {
    
    let image = UIImage(color: UIColor.gray100)
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    private func render() {
        backgroundColor = .gray100
        selectedSegmentTintColor = .blue200
        
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.gray400]
        setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
        
        let titleTextAttributesSelect = [NSAttributedString.Key.foregroundColor: UIColor.white100]
        setTitleTextAttributes(titleTextAttributesSelect, for: .selected)
        selectedSegmentIndex = 0
        setStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UISegmentedControl {
    func setStyle() {
        let tintColorImage = UIImage(color: .blue200)
        setBackgroundImage(UIImage(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
        setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
        setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
        setTitleTextAttributes([.foregroundColor: UIColor.gray400, NSAttributedString.Key.font: UIFont.body2], for: .normal)
        setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
}
