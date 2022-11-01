//
//  KeywordCollectionViewLayout.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

final class KeywordCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private enum Size {
        static let keywordLabelRowSpacing: CGFloat = 16
        static let keywordLabelXSpacing: CGFloat = 10
    }
    
    let cellSpacing: CGFloat = Size.keywordLabelXSpacing
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = Size.keywordLabelRowSpacing
        self.sectionInset = UIEdgeInsets(top: 15, left: SizeLiteral.leadingTrailingPadding, bottom: 0, right: SizeLiteral.leadingTrailingPadding)
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
        
        for i in Keyword.mockData.count..<(attributes?.count ?? 0) {
            attributes?[i].frame.origin.x = SizeLiteral.leadingTrailingPadding
        }
        
        return attributes
    }
}
