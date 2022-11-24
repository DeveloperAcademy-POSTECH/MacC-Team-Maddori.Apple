//
//  MyReflectionMainViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/02.
//

import UIKit

import Alamofire
import SnapKit

final class MyReflectionViewController: BaseViewController {
    
    private let user = UserDefaultStorage.nickname
    private var allReflection: AllReflectionResponse? 
    private var totalReflection: [ReflectionResponse] = [] {
        didSet {
            reflectionCollectionView.reloadData()
        }
    }
    
    private enum Size {
        static let headerHeight: CGFloat = 50
        static let totalReflectionCellHeight: CGFloat = 70
    }
    
    // MARK: - property
    
    private let logOutButton = LogOut(type: .system)
    private lazy var myReflectionTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: user + "님의 회고")
        label.applyColor(to: user, with: .blue200)
        return label
    }()
    private let reflectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white200
        collectionView.register(TotalReflectionCell.self, forCellWithReuseIdentifier: TotalReflectionCell.className)
        collectionView.register(MyReflectionCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyReflectionCollectionViewHeader.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let logOutButton = makeBarButtonItem(with: logOutButton)
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
        setUpLogOutButtonAction()               
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dispatchAllReflection(type: .fetchPastReflectionList(teamId: UserDefaultStorage.teamId))
    }
    
    override func render() {
        view.addSubview(myReflectionTitleLabel)
        myReflectionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(reflectionCollectionView)
        reflectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(myReflectionTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func setUpDelegation() {
        reflectionCollectionView.delegate = self
        reflectionCollectionView.dataSource = self
    }
    
    private func setUpLogOutButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.makeRequestAlert(title: "로그아웃 하시겠습니까?", message: "", okTitle: "확인", cancelTitle: "취소") { _ in
                UserDefaultHandler.clearAllData()
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate
                        as? SceneDelegate else { return }
                sceneDelegate.logout()
            }
        }
        logOutButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - api
    
    private func dispatchAllReflection(type: MyReflectionEndPoint<EncodeDTO>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<AllReflectionResponse>.self) { json in
            if let json = json.value {
                guard let jsonDetail = json.detail else { return }
                self.allReflection = jsonDetail
                if let reflection = jsonDetail.reflection?[0] {
                    self.totalReflection = reflection
                }
            }
        }
    }
}

// MARK: - extension

extension MyReflectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.15, delay: 0, animations: {
                cell.contentView.backgroundColor = .gray100
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.15, delay: 0, animations: {
                cell.contentView.backgroundColor = .white200
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let reflectionId = totalReflection[indexPath.item].id,
              let reflectionName = totalReflection[indexPath.item].reflectionName else { return }
        self.navigationController?.pushViewController(MyReflectionDetailViewController(reflectionId: reflectionId, reflectionName: reflectionName), animated: true)
    }
}

extension MyReflectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if totalReflection.isEmpty {
            collectionView.setEmptyReflectionView()
        } else {
            collectionView.restore()
        }
        return totalReflection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyReflectionCollectionViewHeader.className, for: indexPath) as? MyReflectionCollectionViewHeader else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: Size.totalReflectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalReflectionCell.className, for: indexPath) as? TotalReflectionCell else { return UICollectionViewCell() }
        guard let reflectionName = totalReflection[indexPath.item].reflectionName,
              let date = totalReflection[indexPath.item].date?.formatDateString(to: "Y. M. d. (E)") else { return UICollectionViewCell() }
        
        cell.configLabel(text: reflectionName, date: date)
        return cell
    }
}

extension MyReflectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Size.headerHeight)
    }
}
