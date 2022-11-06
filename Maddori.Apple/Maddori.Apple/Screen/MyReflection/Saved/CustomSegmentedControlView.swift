//
//  CustomSegmentedControlView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import SnapKit

final class CustomSegmentedControlView: UIView {
    
    // MARK: - property
    
    private let segmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 20
        return view
    }()
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue200
        view.layer.cornerRadius = 16
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapContinue(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.text = "Continue"
        label.font = .body2
        label.textColor = .white100
        return label
    }()
    private lazy var unSelectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 16
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapStop(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    private let stopLabel: UILabel = {
        let label = UILabel()
        label.text = "Stop"
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    
    private let segmentSelectedView: UIView = {
        let view = UIView(frame: CGRect(x: 4, y: 4, width: 116, height: 32))
        view.backgroundColor = .blue200
        view.layer.cornerRadius = 16
        view.isUserInteractionEnabled = true
        return view
    }()
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - selector
    
    @objc private func didTapContinue(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1) {
            DispatchQueue.main.async {
                self.unSelectedView.backgroundColor = .gray100
                self.stopLabel.textColor = .gray400
                self.selectedView.backgroundColor = .blue200
                self.continueLabel.textColor = .white100
            }
        }
    }
    
    @objc private func didTapStop(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1) {
            DispatchQueue.main.async {
                self.selectedView.backgroundColor = .gray100
                self.continueLabel.textColor = .gray400
                self.unSelectedView.backgroundColor = .blue200
                self.stopLabel.textColor = .white100
            }
        }
    }
    
    // MARK: - func
    
    private func render() {
        
        addSubview(segmentView)
        segmentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        segmentView.addSubview(segmentSelectedView)
        
        addSubview(selectedView)
        selectedView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(116)
        }

        addSubview(unSelectedView)
        unSelectedView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(116)
        }

        addSubview(continueLabel)
        continueLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.centerX.equalTo(selectedView.snp.centerX)
        }

        addSubview(stopLabel)
        stopLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.centerX.equalTo(unSelectedView.snp.centerX)
        }
    }
}
