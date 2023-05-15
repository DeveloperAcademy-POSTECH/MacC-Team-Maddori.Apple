//
//  AddDetailFeedbackViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import Alamofire
import SnapKit

final class AddFeedbackDetailViewController: BaseViewController {
    
    private var feedbackContent: FeedbackContent
    
    private var isOpenedMemberView: Bool = true {
        didSet {
            if !isOpenedMemberView {
                if toName != "" {
                    selectMemberView.titleLabel.text = toName
                    selectMemberView.titleLabel.textColor = .blue200
                }
            }
            else {
                selectMemberView.titleLabel.text = TextLiteral.toNameTitleLabel
                selectMemberView.titleLabel.textColor = .black100
            }
        }
    }
    private var isOpenedTypeView: Bool = false {
        didSet {
            if !isOpenedTypeView {
                if selectKeywordTypeView.feedbackTypeButtonView.feedbackType != nil {
                    selectKeywordTypeView.titleLabel.text = selectKeywordTypeView.feedbackTypeButtonView.feedbackType?.rawValue
                    selectKeywordTypeView.titleLabel.textColor = .blue200
                }
            }
            else {
                selectKeywordTypeView.titleLabel.text = TextLiteral.feedbackTypeLabel
                selectKeywordTypeView.titleLabel.textColor = .black100
            }
        }
    }
    private var toName: String = ""
    private var toId: Int?
    private var isSelectedMember: Bool = false
    private var isSelectedType: Bool = false
    
    // MARK: - property
    
    private let closeButton = CloseButton()
    private let progressImageView = UIImageView(image: ImageLiterals.imgProgress1)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.DetailTitleLabel
        label.numberOfLines = 0
        label.font = .title2
        label.setLineSpacing(to: 4)
        label.textColor = .black100
        return label
    }()
    private let nextButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.doneButtonNext
        button.isDisabled = true
        return button
    }()
    private lazy var selectMemberView: SelectMemberView = {
        let view = SelectMemberView()
        view.upDownImageView.transform = CGAffineTransform(rotationAngle: .pi)
        view.didSelectedMemeber = { [weak self] user in
            guard let userName = user.userName,
                  let userId = user.userId   else { return }
            self?.toName = userName
            self?.toId = userId
            
            self?.openSelectTypeView()
        }
        return view
    }()
    private lazy var touchView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSelectMemeberView))
        view.addGestureRecognizer(tap)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var selectKeywordTypeView: SelectKeywordTypeView = {
        let view = SelectKeywordTypeView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSelectKeywordTypeView))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // MARK: - life cycle
    
    init(feedbackContent: FeedbackContent) {
        self.feedbackContent = feedbackContent
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButton()
        setupNextButton()
        setupShadowView()
        detectMemberIsSelected()
        detectFeedbackTypeIsSelected()
        fetchTeamDetailMember(type: .fetchTeamMember)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = closeButton
    }
    
    override func render() {
        view.addSubview(progressImageView)
        progressImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(110)
            $0.height.equalTo(14)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressImageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
        }
        
        view.addSubview(selectMemberView)
        selectMemberView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(264)
        }
        
        selectMemberView.addSubview(touchView)
        touchView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(58)
        }
        
        view.addSubview(selectKeywordTypeView)
        selectKeywordTypeView.snp.makeConstraints {
            $0.top.equalTo(selectMemberView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(58)
        }
    }
    
    // MARK: - selector
    
    @objc private func didTapSelectMemeberView() {
        if isOpenedMemberView {
            self.selectMemberView.snp.updateConstraints {
                $0.height.equalTo(58)
            }
            self.isOpenedMemberView.toggle()
            self.selectMemberView.isOpened = self.isOpenedMemberView
            UIView.animate(withDuration: 0.2) {
                self.selectMemberView.upDownImageView.transform = .identity
                self.view.layoutIfNeeded()
            }
        }
        else {
            self.selectMemberView.snp.updateConstraints {
                $0.height.equalTo(264)
            }
            self.isOpenedMemberView.toggle()
            self.selectMemberView.isOpened = self.isOpenedMemberView
            UIView.animate(withDuration: 0.2) {
                self.selectMemberView.upDownImageView.transform = CGAffineTransform(rotationAngle: .pi)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func didTapSelectKeywordTypeView() {
        if isOpenedTypeView {
            self.selectKeywordTypeView.snp.updateConstraints {
                $0.height.equalTo(58)
            }
            self.isOpenedTypeView.toggle()
            self.selectKeywordTypeView.isOpened = self.isOpenedTypeView
            
            UIView.animate(withDuration: 0.2) {
                self.selectKeywordTypeView.upDownImageView.transform = .identity
                self.view.layoutIfNeeded()
            }
        }
        else {
            self.selectKeywordTypeView.snp.updateConstraints {
                $0.height.equalTo(178)
            }
            self.isOpenedTypeView.toggle()
            self.selectKeywordTypeView.isOpened = self.isOpenedTypeView
            
            UIView.animate(withDuration: 0.2) {
                self.selectKeywordTypeView.upDownImageView.transform = CGAffineTransform(rotationAngle: .pi)
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    // MARK: - func
    
    private func setupShadowView() {
        selectMemberView.layer.shadowColor = UIColor.black100.cgColor
        selectMemberView.layer.shadowRadius = 10
        selectMemberView.layer.shadowOpacity = 0.05
        selectMemberView.layer.shadowOffset = CGSize.zero
        
        selectKeywordTypeView.layer.shadowColor = UIColor.black100.cgColor
        selectKeywordTypeView.layer.shadowRadius = 10
        selectKeywordTypeView.layer.shadowOpacity = 0.05
        selectKeywordTypeView.layer.shadowOffset = CGSize.zero
    }
    
    private func setupNextButton() {
        let action = UIAction { [weak self] _ in
            guard let type = self?.selectKeywordTypeView.feedbackTypeButtonView.feedbackType else { return }
            guard let feedback = FeedBackDTO.init(rawValue: type.rawValue) else { return }
            
            self?.feedbackContent = FeedbackContent(toNickName: self?.toName, toUserId: self?.toId, feedbackType: feedback, reflectionId: self?.feedbackContent.reflectionId ?? 1)
            self?.pushAddFeedbackViewController()
        }
        nextButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupCloseButton() {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
    }
    
    private func pushAddFeedbackViewController () {
        let viewController = AddFeedbackContentViewController(feedbackContent: feedbackContent, step: .writeSituation)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func detectFeedbackTypeIsSelected() {
        selectKeywordTypeView.feedbackTypeButtonView.detectSelectedFeedbackType = { [weak self] isSelected in
            self?.isSelectedType = isSelected
            self?.changeNextButtonStatus()
        }
    }
    
    private func detectMemberIsSelected() {
        selectMemberView.isSelectedMember = { [weak self] isSelected in
            self?.isSelectedMember = isSelected
            self?.changeNextButtonStatus()
        }
    }
    
    private func changeNextButtonStatus() {
        if isSelectedMember, isSelectedType {
            nextButton.isDisabled = false
        }
    }
    
    private func openSelectTypeView() {
        self.selectKeywordTypeView.snp.updateConstraints {
            $0.height.equalTo(178)
        }
        self.isOpenedTypeView = true
        self.selectKeywordTypeView.isOpened = true
        UIView.animate(withDuration: 0.2) {
            self.selectKeywordTypeView.upDownImageView.transform = CGAffineTransform(rotationAngle: .pi)
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - api
    
    private func fetchTeamDetailMember(type: TeamDetailEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers).responseDecodable(of: BaseModel<TeamMembersResponse>.self) { json in
            if let data = json.value {
                guard let members = data.detail?.members else { return }
                
                let membersExceptMe = members.filter { $0.userId != UserDefaultStorage.userId }
                DispatchQueue.main.async {
                    self.selectMemberView.memberCollectionView.memberList = membersExceptMe
                }
            }
        }
    }
}
