//
//  TeamDetailMemberTableHeaderView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/03/17.
//

import UIKit

import SnapKit

final class TeamDetailMemberTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - property
    
    private let memberInformationView = MemberInformationView()
    private let dividerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray300.cgColor
        return view
    }()
    
    // MARK: - life cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(memberInformationView)
        memberInformationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        self.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalTo(memberInformationView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setupMemberInfoView(nickname: String, role: String, imagePath: String?) {
        memberInformationView.profileNicknameLabel.text = nickname
        memberInformationView.profileRoleLabel.text = role
        if let imagePath {        
            memberInformationView.profileImageView.load(from: UrlLiteral.imageBaseURL + imagePath)
        }
    }
}
