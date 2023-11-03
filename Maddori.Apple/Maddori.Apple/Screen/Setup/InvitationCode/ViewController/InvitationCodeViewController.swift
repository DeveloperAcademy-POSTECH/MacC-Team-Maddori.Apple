//
//  InvitedCodeViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/23.
//

import UIKit

import Alamofire
import SnapKit

final class InvitationCodeViewController: BaseViewController {
    
    // MARK: - property

    private let invitationCodeView: InvitationCodeView = InvitationCodeView()
    private let toastView: ToastView = ToastView(type: .complete)
    
    // MARK: - init
    
    // MARK: - life cycle
    
    override func loadView() {
        view = invitationCodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - override
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        configureNavigationController()
    }
    
    override func render() {
        setupToastView()
    }
    
    // MARK: - func
    
    private func configureNavigationController() {
        guard let navigationController else { return }
        invitationCodeView.setupNavigationController(navigationController)
        invitationCodeView.setupNavigationItem(navigationItem)
    }
    
    private func setupToastView() {
        guard let navigationController else { return }
        invitationCodeView.setupToastView(navigationController)
    }
}

// MARK: - Helper

private func pushHomeViewController() {
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    sceneDelegate?.changeRootViewCustomTabBarView()
}
