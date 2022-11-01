//
//  UILabel+Extension.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/18.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat){
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    func applyColor(to targetString: String, with color: UIColor) {
        if let labelText = self.text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.foregroundColor,
                                          value: color,
                                          range: (labelText as NSString).range(of: targetString))
            attributedText = attributedString
        }
    }
    
    func setLineSpacing() {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func setTitleFont(text: String) {
        self.text = text
        self.font = .title
        self.setLineSpacing()
        self.numberOfLines = 0
    }
}
