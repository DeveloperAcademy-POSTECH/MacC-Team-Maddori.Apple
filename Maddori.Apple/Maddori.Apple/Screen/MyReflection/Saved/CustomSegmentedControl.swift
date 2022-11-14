//
//  SegmentedControl.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import SnapKit

class CustomSegmentedControl: UISegmentedControl {
    
    // MARK: - property
    
    private lazy var selectedView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments) + 41.5
        let height = 32.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 1.0
        let frame = CGRect(x: xPosition + 24, y: 4, width: width, height: height)
        let view = UIView(frame: frame)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.setGradient(colorTop: .gradientBlueTop, colorBottom: .gradientBlueBottom)
        self.addSubview(view)
        return view
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        configUI()
        self.removeBackgroundAndDivider()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        backgroundColor = .gray100
        selectedSegmentTintColor = .blue200
        
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.gray400]
        setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
        
        let titleTextAttributesSelect = [NSAttributedString.Key.foregroundColor: UIColor.white100]
        setTitleTextAttributes(titleTextAttributesSelect, for: .selected)
        selectedSegmentIndex = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        UIView.animate(
            withDuration: 0.3,
            animations: {
                if self.selectedSegmentIndex == 0 {
                    self.selectedView.frame.origin.x = underlineFinalXPosition + 4
                } else {
                    self.selectedView.frame.origin.x = underlineFinalXPosition
                }
            }
        )
    }
    
    // MARK: - func
    
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}
