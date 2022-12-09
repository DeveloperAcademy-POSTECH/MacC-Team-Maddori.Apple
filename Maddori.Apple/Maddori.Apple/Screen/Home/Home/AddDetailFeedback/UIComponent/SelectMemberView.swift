//
//  SelectMemberView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/12/09.
//

import UIKit

import Alamofire
import SnapKit

final class SelectMemberView: UIStackView {
    
    var isOpened: Bool = false {
        didSet {
            if isOpened {
                self.memberCollectionView.snp.updateConstraints {
                    $0.height.equalTo(190)
                }
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                }
                self.memberCollectionView.isHidden = false
            }
            else {
                self.memberCollectionView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                }
                self.memberCollectionView.isHidden = false
            }
        }
    }
    
    // MARK: - property
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        return view
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .main
        label.text = "피드백 줄 맴버"
        return label
    }()
    let upDownImageView: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.icBottom)
        imageView.tintColor = .black100
        return imageView
    }()
    private lazy var memberCollectionView: MemberCollectionView = {
        let collectionView = MemberCollectionView(type: .addFeedback)
        collectionView.didTappedFeedBackMember = { [weak self] user in
            //FIXME: 네네 바꿔야해요
            print(user.userName)
        }
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
        fetchCurrentTeamMember(type: .fetchCurrentTeamMember)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    private func render() {
        
        self.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(58)
        }
        
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }

        titleView.addSubview(upDownImageView)
        upDownImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        self.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(190)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white100
        self.layer.cornerRadius = 10
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
                    self.memberCollectionView.memberList = memberList
                }
            }
        }
    }
}
