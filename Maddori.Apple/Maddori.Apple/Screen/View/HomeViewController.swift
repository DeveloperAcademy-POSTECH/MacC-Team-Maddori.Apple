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
    
    private let first: KeywordLabel = {
        let keyword = KeywordLabel()
        keyword.text = "첫 번째"
        keyword.font = UIFont.systemFont(ofSize: 18)
        keyword.textColor = .white
        keyword.backgroundColor = UIColor(hex: "4776FB")
        return keyword
    }()
    private let second: KeywordLabel = {
        let keyword = KeywordLabel()
        keyword.text = "첫 번째"
        keyword.font = UIFont.systemFont(ofSize: 18)
        keyword.textColor = .white
        keyword.backgroundColor = UIColor(hex: "4776FB")
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
        view.backgroundColor = .backgroundWhite
    }
    
    private func render() {
        view.addSubview(first)
        first.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    // MARK: - selector
}
