//
//  SelectKeywordTypeView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/12/09.
//

import UIKit

import SnapKit

final class SelectKeywordTypeView: UIStackView {
    
    var isOpened: Bool = false {
        didSet {
            if isOpened {
                self.feedbackTypeButtonView.isHidden = false
                setupFeedbackTypeButtonViewLayOut()
            }
            else {
                feedbackTypeButtonView.removeFromSuperview()
                
                self.feedbackTypeButtonView.snp.updateConstraints {
                    $0.bottom.equalTo(self.snp.bottom)
                }
            }
        }
    }
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
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
    private lazy var titleView: UIView = {
        let view = UIView()
        return view
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
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func setupFeedbackTypeButtonViewLayOut() {
        self.addSubview(feedbackTypeButtonView)
        feedbackTypeButtonView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalTo(self.snp.bottom).inset(20)
        }
    }
        
    private func render() {
        
        self.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
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
    }
    
    private func configUI() {
        self.backgroundColor = .white100
        self.layer.cornerRadius = 10
    }
}

