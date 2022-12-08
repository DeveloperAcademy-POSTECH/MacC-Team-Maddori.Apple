//
//  SelectKeywordTypeView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/12/09.
//

import UIKit

final class SelectKeywordTypeView: UIView {
    
    var isOpened: Bool = false {
        didSet {
            if isOpened {
                self.addSubview(self.feedbackTypeButtonView)
                self.feedbackTypeButtonView.snp.makeConstraints {
                    $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.bottom.equalToSuperview().inset(20)
                }
                self.feedbackTypeButtonView.isHidden = false
            }
            else {
                self.feedbackTypeButtonView.removeFromSuperview()
            }
        }
    }
    
    // MARK: - property
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .main
        label.text = "피드백 종류"
        return label
    }()
    let upDownImageView: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.icBottom)
        imageView.tintColor = .black100
        return imageView
    }()
    private let feedbackTypeButtonView: FeedbackTypeButtonView = {
        let view = FeedbackTypeButtonView()
        view.isHidden = true
        return view
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    private func render() {
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.addSubview(upDownImageView)
        upDownImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white100
        self.layer.cornerRadius = 10
    }
}

