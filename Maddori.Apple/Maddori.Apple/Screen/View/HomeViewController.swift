//
//  HomeViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - property
    
    private let firstLabel: KeywordLabel = {
        let keyword = KeywordLabel()
        keyword.keywordType = .defaultKeyword
        keyword.text = "첫 djdkdkdk번째"
        return keyword
    }()
    private let secondLabel: KeywordLabel = {
        let keyword = KeywordLabel()
        keyword.text = "첫 번째"
        keyword.keywordType = .previewKeyword
        return keyword
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }
    
    // MARK: - func
    
    private func configUI() {
        view.backgroundColor = .black
    }
    
    private func render() {
        view.addSubview(firstLabel)
        firstLabel.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        view.addSubview(secondLabel)
        secondLabel.snp.makeConstraints {
            $0.left.equalTo(firstLabel.snp.right).inset(-10)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    // MARK: - selector
}
