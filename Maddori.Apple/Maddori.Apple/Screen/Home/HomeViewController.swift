//
//  HomeViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

import SnapKit

final class HomeViewController: BaseViewController {
    private let homeService = HomeAPI(apiService: APIService())
    
    var keywordList: [Keyword] = []
    var isTouched = false
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        // FIXME: 기존 간격인 10으로 하면
        static let labelPadding: CGFloat = 5
        static let labelButtonPadding: CGFloat = 6
        static let propertyPadding: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 27
        static let mainButtonHeight: CGFloat = 54
        static let subButtonWidth: CGFloat = 54
        static let subButtonHeight: CGFloat = 20
        static let planReflectionViewHeight: CGFloat = 40
    }
    
    // MARK: - property
    
    private let warningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icWarning
        imageView.tintColor = .yellow300
        return imageView
    }()
    private let toastLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Flight에선 지원되지 않습니다"
        label.font = UIFont.font(.medium, ofSize: 14)
        label.textColor = .white100
        return label
    }()
    private let toastView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    lazy var keywordCollectionView: UICollectionView = {
        let flowLayout = KeywordCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white200
        collectionView.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: KeywordCollectionViewCell.className)
        return collectionView
    }()
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.mainViewControllerTeamName)
        label.textColor = .black100
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerReflectionDateDescription
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    private let currentReflectionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerCurrentReflectionKeyword
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private lazy var addFeedbackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white100
        button.setTitle(TextLiteral.mainViewControllerButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .main
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue200.cgColor
        button.layer.cornerRadius = Size.buttonCornerRadius
        // TODO: button action 추가
        let action = UIAction { [weak self] _ in
            self?.didTapAddFeedbackButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        getAllCss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
        render()
    }
    
    override func configUI() {
        view.backgroundColor = .white200
        setGradientToastView()
    }
    
    override func render() {
        navigationController?.view.addSubview(toastView)
        toastView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(46)
        }
        
        toastView.addSubview(toastLabel)
        toastLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        toastView.addSubview(warningImageView)
        warningImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        view.addSubview(teamNameLabel)
        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(Size.labelPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(currentReflectionLabel)
        currentReflectionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Size.propertyPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(addFeedbackButton)
        addFeedbackButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.bottomPadding)
            $0.height.equalTo(Size.mainButtonHeight)
        }
        
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(Size.labelPadding)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(addFeedbackButton.snp.top).offset(-10)
        }
    }
    
    // MARK: - func
    
    private func setUpDelegation() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func didTapAddFeedbackButton() {
        let vc = UINavigationController(rootViewController: FromToViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func setGradientToastView() {
        toastView.layoutIfNeeded()
        toastView.setGradient(colorTop: .gradientGrayTop, colorBottom: .gradientGrayBottom)
    }
    
    private func showToastPopUp() {
        if !isTouched {
            isTouched = true
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.toastView.transform = CGAffineTransform(translationX: 0, y: 115)
            }, completion: {_ in
                UIView.animate(withDuration: 1, delay: 0.5, animations: {
                    self.toastView.transform = .identity
                }, completion: {_ in
                    self.isTouched = false
                })
            })
        }
    }
    
    // MARK: - API
    
    private func getAllCss() {
        Task {
            do {
                if let data = try await homeService.fetchCssList()?.keywords {
                    keywordList.removeAll()
                    data.map {
                        keywordList.append(Keyword(string: $0, type: .defaultKeyword))
                    }
                    print("keywordList", keywordList)
                    keywordCollectionView.reloadData()
                }
            } catch NetworkError.serverError {
                print("serverError")
            } catch NetworkError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
    }
}

// MARK: - extension

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordList.count
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.className, for: indexPath) as? KeywordCollectionViewCell else {
            return UICollectionViewCell()
        }
        let keyword = keywordList[indexPath.row]
        cell.keywordLabel.text = keyword.string
        // FIXME: cell을 여기서 접근하는건 안좋은 방법일수도?
        cell.configShadow(type: keywordList[indexPath.row].type)
        cell.configLabel(type: keywordList[indexPath.row].type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        UIDevice.vibrate()
        showToastPopUp()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: keywordList[indexPath.item].string)
    }
}

