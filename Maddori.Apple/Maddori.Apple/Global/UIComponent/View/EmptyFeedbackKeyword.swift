//
//  EmptyFeedbackKeyword.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/06.
//

import UIKit

import SnapKit

final class EmptyFeedbackKeyword: UIView {
    
    // MARK: - property
    
    private let emptyFeedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백"
        label.textColor = .gray700
        label.font = .main
        return label
    }()
    
    // MARK: - life cycle
    
    override func draw(_ rect: CGRect) {
        let linePattern: [CGFloat] = [5, 4]
        let path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 2, y: 2),
                                                    size: CGSize(width: 84, height: 50)),
                                cornerRadius: 25)
        path.setLineDash(linePattern, count: linePattern.count, phase: 0)
        path.lineWidth = 3
        
        UIColor.white200.set()
        path.fill()
        UIColor.gray700.set()
        path.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white200
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(emptyFeedbackLabel)
        emptyFeedbackLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
