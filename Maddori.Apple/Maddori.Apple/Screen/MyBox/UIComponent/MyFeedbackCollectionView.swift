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
        static let resizingTextLineOneHeight: CGFloat = 53
        static let resizingTextLineTwoHeight: CGFloat = 75
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width - (SizeLiteral.leadingTrailingPadding * 2)
        static let collectionViewInset = UIEdgeInsets.init(top: Size.topSpacing,
                                                           left: Size.horizontalPadding,
                                                           bottom: 15,
                                                           right: Size.horizontalPadding)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionViewInset
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
        if indexPath.section == 0 {
            header.setDividerHidden(true)
        } else {
            header.setDividerHidden(false)
        }
        header.setCssLabelText(with: indexPath.section)
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
extension MyFeedbackCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockData.filter { $0.type == FeedBackType.allCases[section] }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedbackCollectionViewCell.className, for: indexPath) as? MyFeedbackCollectionViewCell else { return UICollectionViewCell() }
        var data: [FeedBack] = []
        switch indexPath.section {
        case 0:
            data = mockData.filter { $0.type == .continueType }
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
    
    // FIXME: - 예외 처리해야함 (continue와 start만 있다던지?)
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
        if indexPath.section == 0 {
            data = mockData.filter { $0.type == .continueType }
        } else {
            data = mockData.filter { $0.type == .stopType }
        }
        let cellHeight = UILabel.textSize(font: .body2, text: data[indexPath.item].content, width: Size.cellContentWidth, height: 0).height
        let isOneTextLine = cellHeight < 18
        if isOneTextLine {
            return CGSize(width: Size.cellWidth, height: Size.resizingTextLineOneHeight)
        } else {
            return CGSize(width: Size.cellWidth, height: Size.resizingTextLineTwoHeight)
        }
    }
}
