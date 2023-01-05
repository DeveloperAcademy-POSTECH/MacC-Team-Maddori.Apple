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
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width - (SizeLiteral.leadingTrailingPadding)
        static let collectionViewInset = UIEdgeInsets.init(top: Size.topSpacing,
                                                           left: Size.horizontalPadding,
                                                           bottom: 20,
                                                           right: 0)
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
        collectionView.register(EmptyCollectionFeedbackView.self, forCellWithReuseIdentifier: EmptyCollectionFeedbackView.className)
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
        guard let data = feedbackInfo else { return }
        if !(data.continueArray.isEmpty && data.stopArray.isEmpty) {
            let hasContinueStop = collectionView.numberOfSections == 2
            let isContinueSection = indexPath.section == 0
            if hasContinueStop {
                let reflectionId = data.reflectionId ?? 0
                let feedbackId = isContinueSection
                ? data.continueArray[indexPath.item].id ?? 0
                : data.stopArray[indexPath.item].id ?? 0
                let nickName = data.toUsername ?? ""
                let keyword = isContinueSection
                ? data.continueArray[indexPath.item].keyword ?? ""
                : data.stopArray[indexPath.item].keyword ?? ""
                let info = isContinueSection
                ? data.continueArray[indexPath.item].content ?? ""
                : data.stopArray[indexPath.item].content ?? ""
                let start = isContinueSection
                ? data.continueArray[indexPath.item].startContent
                : data.stopArray[indexPath.item].startContent
                let reflectionStatus = ReflectionStatus.init(rawValue: feedbackInfo?.reflectionStatus ?? "Before")
                
                let data = FeedbackFromMeModel(reflectionId: reflectionId,
                                               feedbackId: feedbackId,
                                               nickname: nickName,
                                               feedbackType: indexPath.section == 0 ? .continueType : .stopType,
                                               keyword: keyword,
                                               info: info,
                                               start: start,
                                               reflectionStatus: reflectionStatus ?? .Before
                )
                didTappedCell?(data)
            } else {
                let continueArray = data.continueArray
                let stopArray = data.stopArray
                let reflectionStatus = ReflectionStatus.init(rawValue: data.reflectionStatus ?? "Before")
                if !continueArray.isEmpty {
                    let data = FeedbackFromMeModel(reflectionId: data.reflectionId ?? 0,
                                                   feedbackId: continueArray[indexPath.item].id ?? 0,
                                                   nickname: data.toUsername ?? "",
                                                   feedbackType: .continueType,
                                                   keyword: continueArray[indexPath.item].keyword ?? "",
                                                   info: continueArray[indexPath.item].content ?? "",
                                                   start: continueArray[indexPath.item].startContent,
                                                   reflectionStatus: reflectionStatus ?? .Before
                    )
                    didTappedCell?(data)
                } else {
                    let data = FeedbackFromMeModel(reflectionId: data.reflectionId ?? 0,
                                                   feedbackId: stopArray[indexPath.item].id ?? 0,
                                                   nickname: data.toUsername ?? "",
                                                   feedbackType: .stopType,
                                                   keyword: stopArray[indexPath.item].keyword ?? "",
                                                   info: stopArray[indexPath.item].content ?? "",
                                                   start: stopArray[indexPath.item].startContent,
                                                   reflectionStatus: reflectionStatus ?? .Before
                    )
                    didTappedCell?(data)
                }
            }
        }
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionFeedbackView.className, for: indexPath) as? EmptyCollectionFeedbackView else { return UICollectionViewCell() }
            cell.emptyFeedbackLabel.text = TextLiteral.emptyViewMyBox
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedbackCollectionViewCell.className, for: indexPath) as? MyFeedbackCollectionViewCell else { return UICollectionViewCell() }
            guard let data = feedbackInfo else { return UICollectionViewCell() }
            let hasContinue = !data.continueArray.isEmpty
            switch indexPath.section {
            case 0:
                if hasContinue {
                    cell.setCellLabel(title: data.continueArray[indexPath.item].keyword ?? "",
                                      content: data.continueArray[indexPath.item].content ?? "")
                } else {
                    cell.setCellLabel(title: data.stopArray[indexPath.item].keyword ?? "",
                                      content: data.stopArray[indexPath.item].content ?? "")
                }
                if indexPath.item == data.continueArray.count - 1 {
                    cell.isDividerHidden = true
                } else {
                    cell.isDividerHidden = false
                }
            case 1:
                cell.setCellLabel(title: data.stopArray[indexPath.item].keyword ?? "",
                                  content: data.stopArray[indexPath.item].content ?? "")
                if indexPath.item == data.stopArray.count - 1 {
                    cell.isDividerHidden = true
                } else {
                    cell.isDividerHidden = false
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
