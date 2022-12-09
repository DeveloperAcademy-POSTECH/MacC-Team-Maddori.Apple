//
//  AddDetailFeedbackViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import Alamofire
import SnapKit

final class AddDetailFeedbackViewController: BaseViewController {
    
    private var feedbackContent: FeedbackContent?
    
    private var isOpenedMemberView: Bool = true {
        didSet {
            if !isOpenedMemberView {
                selectMemberView.titleLabel.text = toName
                selectMemberView.titleLabel.textColor = .blue200
            }
            else {
                selectMemberView.titleLabel.text = "피드백 줄 멤버"
                selectMemberView.titleLabel.textColor = .black100
            }
        }
    }
    private var isOpenedTypeView: Bool = false
    private var toName: String = ""
    
    // MARK: - property
    
    private let closeButton = CloseButton()
    private let progressImageView = UIImageView(image: ImageLiterals.imgProgress1)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백 줄 멤버와 종류를\n선택해주세요"
        label.numberOfLines = 0
        label.font = .title2
        return label
    }()
    private let nextButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.doneButtonNext
        return button
    }()
    private lazy var selectMemberView: SelectMemberView = {
        let view = SelectMemberView()
        view.upDownImageView.transform = CGAffineTransform(rotationAngle: .pi)
        view.didSelectedMemeber = { [weak self] userName in
            self?.toName = userName
            self?.feedbackContent = FeedbackContent(toName: self?.toName)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButton()
        setupNextButton()
        setupShadowView()
        fetchCurrentTeamMember(type: .fetchCurrentTeamMember)
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
            let feedback = FeedBackDTO.init(rawValue: type.rawValue)
            self?.feedbackContent = FeedbackContent(keywordType: feedback)
        }
        nextButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupCloseButton() {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - api
    
    private func fetchCurrentTeamMember(type: AddFeedBackEndPoint<AddReflectionDTO>) {
        AF.request(
            type.address,
            method: type.method,
            headers: type.headers
        ).responseDecodable(of: BaseModel<TeamMembersResponse>.self) { json in
            dump(json.value)
            if let data = json.value {
                guard let allMemberList = data.detail?.members else { return }
                let memberList = allMemberList.filter { $0.userName != UserDefaultStorage.nickname }
                DispatchQueue.main.async {
                    self.selectMemberView.memberCollectionView.memberList = memberList
                }
            }
        }
    }
}

struct FeedbackContent {
    var toName: String?
    var keywordType: FeedBackDTO?
}
