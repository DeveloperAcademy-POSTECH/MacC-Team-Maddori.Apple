//
//  SelectMemberView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/12/09.
//

import UIKit

import SnapKit

final class SelectMemberView: UIStackView {
    
    let mockData: [MemberResponse] = [
        MemberResponse(userId: 0, userName: "이드"),
        MemberResponse(userId: 0, userName: "호야"),
        MemberResponse(userId: 0, userName: "케미"),
        MemberResponse(userId: 0, userName: "진저"),
        MemberResponse(userId: 0, userName: "메리"),
        MemberResponse(userId: 0, userName: "곰민"),
    ]
    
    var isOpened: Bool = false {
        didSet {
            if isOpened {
                self.memberCollectionView.snp.updateConstraints {
                    $0.height.equalTo(216)
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
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
        memberCollectionView.memberList = mockData
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(190)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white100
        self.layer.cornerRadius = 10
    }
}
