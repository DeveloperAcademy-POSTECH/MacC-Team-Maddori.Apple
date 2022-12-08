//
//  SelectMemberView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/12/09.
//

import UIKit

final class SelectMemberView: UIView {
    
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
                self.addSubview(self.memberCollectionView)
                self.memberCollectionView.snp.makeConstraints {
                    $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.bottom.equalToSuperview().inset(20)
                }
                self.memberCollectionView.isHidden = false
            }
            else {
                self.memberCollectionView.removeFromSuperview()
            }
        }
    }
    
    // MARK: - property
    
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
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    private func render() {
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.addSubview(upDownImageView)
        upDownImageView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.trailing.equalToSuperview().inset(20)
            
        }
        
        self.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white100
        self.layer.cornerRadius = 10
    }
}
