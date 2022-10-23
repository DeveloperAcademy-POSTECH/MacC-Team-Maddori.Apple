//
//  ReflectionInfoViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/23.
//

import UIKit

import SnapKit

final class ReflectionInfoViewController: BaseViewController {
    let viewModel: ReflectionInfoModel
    
    // MARK: - property
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.nickname)님이 보낸 \(viewModel.type.rawValue)"
        label.textColor = .gray400
        label.applyColor(to: "\(viewModel.type.rawValue)", with: .blue200)
        label.font = .caption1
        return label
    }()
    
    // MARK: - life cycle
    
    init(viewModel: ReflectionInfoModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        view.addSubview(titleText)
        titleText.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide
                .snp.top).inset(55)
        }
    }
}
