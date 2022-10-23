//
//  Size.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import Foundation

enum SizeLiteral {
    
    // MARK: - common
    
    static let leadingTrailingPadding: CGFloat = 24
    static let topPadding: CGFloat = 12
    static let minimumTouchArea: CGFloat = 44
    static let topComponentPadding: CGFloat = 40
    static let labelComponentPadding: CGFloat = 10
    static let componentIntervalPadding: CGFloat = 36
    static let componentCornerRadius: CGFloat = 10
    
    static let keywordLabelHeight: CGFloat = 50
    static let keywordLabelXSpacing: CGFloat = 10
    // TODO: 기존에는 16 이었는데 그렇게 하면 한 글자일 때 cornerRadius 때문에 뾰족해짐
    static let keywordLabelXInset: CGFloat = 17
    static let keywordLabelRowSpacing: CGFloat = 16
}
