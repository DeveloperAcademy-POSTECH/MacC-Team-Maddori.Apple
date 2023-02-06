//
//  TeamManageViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/01/24.
//

import UIKit

import SnapKit

final class TeamManageViewController: BaseViewController {
    
    // MARK: - property
    private let tempView: UIView = {
        let view = UIView()
        return view
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubview(tempView)
        tempView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(275) // FIXME: 수치 바꿀것
            $0.top.equalToSuperview()
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalTo(tempView.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalTo(6)
        }
    }
    
    override func configUI() {
        super.configUI()
    }
    
    // MARK: - func
}
