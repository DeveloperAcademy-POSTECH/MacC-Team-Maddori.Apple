//
//  MyFeedbackCollectionView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackCollectionView: UIView {
    var didTappedCell: ((FeedbackFromMeModel) -> ())?
    var feedbackInfo: FeedBackInfoResponse? {
        didSet {
            feedbackCollectionView.reloadData()
        }
    }
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
        collectionView.register(EmptyFeedbackView.self, forCellWithReuseIdentifier: EmptyFeedbackView.className)
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
        if let feedbackInfo {
            if indexPath.section == 0 {
                header.setDividerHidden(true)
            } else {
                header.setDividerHidden(false)
            }
            let hasContinue = !feedbackInfo.continueArray.isEmpty
            let hasOnlyStop = !feedbackInfo.stopArray.isEmpty
            if hasContinue {
                header.isHidden = false
                header.setCssLabelText(with: indexPath.section)
            } else if hasOnlyStop {
                header.isHidden = false
                header.setCssLabelText(with: 1)
            } else {
                header.isHidden = true
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reflectionId = feedbackInfo?.reflectionId ?? 0
        let feedbackId = indexPath.section == 0
        ? feedbackInfo?.continueArray[indexPath.item].id ?? 0
        : feedbackInfo?.stopArray[indexPath.item].id ?? 0
        let nickName = feedbackInfo?.toUsername ?? ""
        let keyword = indexPath.section == 0
        ? feedbackInfo?.continueArray[indexPath.item].keyword ?? ""
        : feedbackInfo?.stopArray[indexPath.item].keyword ?? ""
        let info = indexPath.section == 0
        ? feedbackInfo?.continueArray[indexPath.item].content ?? ""
        : feedbackInfo?.stopArray[indexPath.item].content ?? ""
        let start = indexPath.section == 0
        ? feedbackInfo?.continueArray[indexPath.item].startContent
        : feedbackInfo?.stopArray[indexPath.item].startContent
        
        let data = FeedbackFromMeModel(reflectionId: reflectionId,
                                       feedbackId: feedbackId,
                                       nickname: nickName,
                                       feedbackType: indexPath.section == 0 ? .continueType : .stopType,
                                       keyword: keyword,
                                       info: info,
                                       start: start)
        didTappedCell?(data)
    }
}
extension MyFeedbackCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = feedbackInfo else { return 0 }
        if data.continueArray.isEmpty && data.stopArray.isEmpty {
            return 1
        }
        let hasContinue = !data.continueArray.isEmpty
        let hasBoth = hasContinue && !data.stopArray.isEmpty
        if hasBoth {
            if section == 0 {
                return data.continueArray.count
            } else {
                return data.stopArray.count
            }
        } else if hasContinue {
            return data.continueArray.count
        } else {
            return data.stopArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = feedbackInfo else { return UICollectionViewCell() }
        if data.continueArray.isEmpty && data.stopArray.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyFeedbackView.className, for: indexPath) as? EmptyFeedbackView else { return UICollectionViewCell() }
            cell.emptyFeedbackLabel.text = TextLiteral.emptyViewMyBox
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedbackCollectionViewCell.className, for: indexPath) as? MyFeedbackCollectionViewCell else { return UICollectionViewCell() }
            guard let data = feedbackInfo else { return UICollectionViewCell() }
            let hasContinue = !data.continueArray.isEmpty
            switch indexPath.section {
            case 0:
                if hasContinue {
                    cell.setCellLabel(title: data.continueArray[indexPath.item].keyword ?? "", content: data.continueArray[indexPath.item].content ?? "")
                } else {
                    cell.setCellLabel(title: data.stopArray[indexPath.item].keyword ?? "", content: data.stopArray[indexPath.item].content ?? "")
                }
                if indexPath.item == data.continueArray.count - 1 {
                    cell.setDividerHidden(true)
                }
            case 1:
                cell.setCellLabel(title: data.stopArray[indexPath.item].keyword ?? "", content: data.stopArray[indexPath.item].content ?? "")
                if indexPath.item == data.stopArray.count - 1 {
                    cell.setDividerHidden(true)
                }
            default:
                break
            }
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let data = feedbackInfo else { return 1 }
        if !data.continueArray.isEmpty && !data.stopArray.isEmpty {
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
        guard let data = feedbackInfo else { return .zero }
        if data.continueArray.isEmpty && data.stopArray.isEmpty {
            return CGSize(width: 300, height: 300)
        } else {
            var feedbackList: [String] = []
            guard let data = feedbackInfo else { return .zero }
            let hasContinue = !data.continueArray.isEmpty
            if hasContinue {
                if indexPath.section == 0 {
                    feedbackList = feedbackInfo?.continueArray.map { $0.content ?? "" } ?? []
                } else {
                    feedbackList = feedbackInfo?.stopArray.map { $0.content ?? "" } ?? []
                }
            } else {
                feedbackList = feedbackInfo?.stopArray.map { $0.content ?? "" } ?? []
            }
            let cellHeight = UILabel.textSize(font: .body2, text: feedbackList[indexPath.item], width: Size.cellContentWidth - 24, height: 0).height
            let isOneTextLine = cellHeight < 18
            if isOneTextLine {
                return CGSize(width: Size.cellWidth, height: Size.resizingTextLineOneHeight)
            } else {
                return CGSize(width: Size.cellWidth, height: Size.resizingTextLineTwoHeight)
            }
        }
    }
}
