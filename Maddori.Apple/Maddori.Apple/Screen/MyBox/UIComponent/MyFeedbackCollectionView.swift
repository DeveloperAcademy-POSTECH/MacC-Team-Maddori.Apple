//
//  MyFeedbackCollectionView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackCollectionView: UIView {
    private let mockData = FeedBack.mockData
    private enum Size {
        static let horizontalPadding: CGFloat = 24
        static let topSpacing: CGFloat = 24
        static let cellContentWidth: CGFloat = UIScreen.main.bounds.size.width - SizeLiteral.leadingTrailingPadding - 66
        static let resizingTextLineOneHeight: CGFloat = 65
        static let resizingTextLineTwoHeight: CGFloat = 87
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width - (SizeLiteral.leadingTrailingPadding * 2)
        static let collectionViewInset = UIEdgeInsets.init(top: Size.topSpacing,
                                                           left: Size.horizontalPadding,
                                                           bottom: 20,
                                                           right: Size.horizontalPadding)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionViewInset
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }()
    private lazy var feedbackCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .backgroundWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyFeedbackHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyFeedbackHeaderView.className)
        collectionView.register(MyFeedbackCollectionViewCell.self, forCellWithReuseIdentifier: MyFeedbackCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(feedbackCollectionView)
        feedbackCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

    // MARK: - extension

extension MyFeedbackCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyFeedbackHeaderView.className, for: indexPath) as? MyFeedbackHeaderView else { return UICollectionReusableView() }
        if !mockData.isEmpty {
            if indexPath.section == 0 {
                header.setDividerHidden(true)
            } else {
                header.setDividerHidden(false)
            }
            let hasContinue = mockData.contains(where: { $0.type == .continueType} )
            if hasContinue {
                header.setCssLabelText(with: indexPath.section)
            } else {
                header.setCssLabelText(with: 1)
            }
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return header
            default:
                return UICollectionReusableView()
            }
        }
        return header
    }
}
extension MyFeedbackCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mockData.isEmpty {
            collectionView.setEmptyFeedbackView(with: TextLiteral.emptyViewMyBox)
        } else {
            collectionView.restore()
        }
        let hasContinue = mockData.contains(where: { $0.type == .continueType} )
        if hasContinue {
            if mockData.filter({ $0.type == FeedBackType.allCases[section] }).count == 0 {
                collectionView.setEmptyReflectionView()
            } else {
                collectionView.restore()
            }
            return mockData.filter { $0.type == FeedBackType.allCases[section] }.count
        } else {
            return mockData.filter { $0.type == .stopType }.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedbackCollectionViewCell.className, for: indexPath) as? MyFeedbackCollectionViewCell else { return UICollectionViewCell() }
        var data: [FeedBack] = []
        let hasContinue = mockData.contains(where: { $0.type == .continueType} )
        switch indexPath.section {
        case 0:
            if hasContinue {
                data = mockData.filter { $0.type == .continueType }
            } else {
                data = mockData.filter { $0.type == .stopType }
            }
            if indexPath.item == data.count - 1 {
                cell.setDividerHidden(true)
            }
        case 1:
            data = mockData.filter { $0.type == .stopType }
            if indexPath.item == data.count - 1 {
                cell.setDividerHidden(true)
            }
        default:
            break
        }
        cell.setCellLabel(title: data[indexPath.item].title, content: data[indexPath.item].content)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if mockData.contains(where: { $0.type == .continueType }) && mockData.contains(where: { $0.type == .stopType }) {
            return 2
        } else {
            return 1
        }
    }
}

extension MyFeedbackCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 80, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var data: [FeedBack] = []
        let hasContinue = mockData.contains(where: { $0.type == .continueType} )
        if hasContinue {
            if indexPath.section == 0 {
                data = mockData.filter { $0.type == .continueType }
            } else {
                data = mockData.filter { $0.type == .stopType }
            }
        } else {
            data = mockData.filter { $0.type == .stopType }
        }
        let cellHeight = UILabel.textSize(font: .body2, text: data[indexPath.item].content, width: Size.cellContentWidth - 24, height: 0).height
        let isOneTextLine = cellHeight < 18
        if isOneTextLine {
            return CGSize(width: Size.cellWidth, height: Size.resizingTextLineOneHeight)
        } else {
            return CGSize(width: Size.cellWidth, height: Size.resizingTextLineTwoHeight)
        }
    }
}
