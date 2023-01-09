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
    
    var didSelectedMemeber: ((MemberResponse) -> ())?
    var isSelectedMember: ((Bool) -> ())?
    
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
        view.layer.cornerRadius = 10
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .main
        label.text = TextLiteral.toNameTitleLabel
        return label
    }()
    let upDownImageView: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.icBottom)
        imageView.tintColor = .black100
        return imageView
    }()
    lazy var memberCollectionView: MemberCollectionView = {
        let collectionView = MemberCollectionView(type: .addFeedback)
        collectionView.didTappedFeedBackMember = { [weak self] user in
            self?.didSelectedMemeber?(user)
            self?.isSelectedMember?(true)
        }
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
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
}
