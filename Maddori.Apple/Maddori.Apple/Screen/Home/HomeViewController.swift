//
//  HomeViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

import SnapKit

final class HomeViewController: BaseViewController {
    
    fileprivate let keywords = Keyword.mockData
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        static let labelButtonPadding: CGFloat = 6
        static let propertyPadding: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 27
        static let mainButtonHeight: CGFloat = 54
        static let subButtonWidth: CGFloat = 54
        static let subButtonHeight: CGFloat = 20
        static let planReflectionViewHeight: CGFloat = 40
    }
    
    // MARK: - property
    
    private lazy var keywordCollectionView: UICollectionView = {
        let flowLayout = KeywordCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white200
        collectionView.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: KeywordCollectionViewCell.className)
        return collectionView
    }()
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.mainViewControllerTeamName)
        label.textColor = .black100
        label.numberOfLines = 0
        return label
    }()
    private let invitationCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.mainViewControllerInvitationButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .caption2
        button.backgroundColor = .gray100
        button.layer.cornerRadius = 4
        return button
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerReflectionDateDescription
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    private let currentReflectionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerCurrentReflectionKeyword
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private let planLabelButtonView: LabelButtonView = {
        let labelButton = LabelButtonView()
        labelButton.subText = TextLiteral.mainViewControllerPlanLabelButtonSubText
        labelButton.subButtonText = TextLiteral.mainViewControllerPlanLabelButtonSubButtonText
        return labelButton
    }()
    private let addFeedbackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white100
        button.setTitle(TextLiteral.mainViewControllerButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .main
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue200.cgColor
        button.layer.cornerRadius = Size.buttonCornerRadius
        // TODO: button action 추가
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
    }
    
    override func configUI() {
        view.backgroundColor = .white200
    }
    
    override func render() {
        view.addSubview(teamNameLabel)
        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(invitationCodeButton)
        invitationCodeButton.snp.makeConstraints {
            $0.leading.equalTo(teamNameLabel.snp.trailing).offset(Size.labelButtonPadding)
            $0.width.equalTo(Size.subButtonWidth)
            $0.height.equalTo(Size.subButtonHeight)
            $0.bottom.equalTo(teamNameLabel.snp.bottom).offset(-5)
            // offset을 없애면 너무 낮은 것 같다는 생각에 임의로 줘봤습니다
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(SizeLiteral.titleSubTitlePadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(currentReflectionLabel)
        currentReflectionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Size.propertyPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(addFeedbackButton)
        addFeedbackButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.bottomPadding)
            $0.height.equalTo(Size.mainButtonHeight)
        }
        
        view.addSubview(planLabelButtonView)
        planLabelButtonView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(addFeedbackButton.snp.top)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
        }
        
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubTitlePadding)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(planLabelButtonView.snp.top)
        }
    }
    
    // MARK: - func
    
    private func setUpDelegation() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
}

// MARK: - extension

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.className, for: indexPath) as? KeywordCollectionViewCell else {
            return UICollectionViewCell()
        }
        let keyword = keywords[indexPath.item]
        // FIXME: cell을 여기서 접근하는건 안좋은 방법일수도?
        cell.keywordLabel.text = keyword.string
        cell.configShadow(type: .previewKeyword)
        cell.configLabel(type: .previewKeyword)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: keywords[indexPath.item].string)
    }
}

