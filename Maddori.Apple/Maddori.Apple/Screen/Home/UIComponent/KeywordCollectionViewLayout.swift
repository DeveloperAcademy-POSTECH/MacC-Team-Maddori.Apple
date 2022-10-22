//
//  KeywordCollectionViewLayout.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

class KeywordCollectionViewLayout: UICollectionViewFlowLayout {
    
    private enum Size {
        static let keywordLabelRowSpacing: CGFloat = 16
        static let keywordLabelXSpacing: CGFloat = 10
    }
    
    let cellSpacing: CGFloat = Size.keywordLabelXSpacing
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = Size.keywordLabelRowSpacing
        self.sectionInset = UIEdgeInsets(top: 15, left: 24, bottom: 0, right: 24)
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
