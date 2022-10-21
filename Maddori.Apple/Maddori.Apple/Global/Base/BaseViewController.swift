//
//  BaseViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        print("success deallocation")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
        setupBackButton()
        setupNavigationBar()
        hideKeyboardWhenTappedAround()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInteractivePopGestureRecognizer()
    }

    func render() {
        // Override Layout
    }

    func configUI() {
        view.backgroundColor = .backgroundWhite
    }

    func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        // FIXME: - navigation title font 설정
//        let font = UIFont.font(.regular, ofSize: 14)

//        appearance.titleTextAttributes = [.font: font]
        appearance.shadowColor = .clear
        appearance.backgroundColor = .backgroundWhite

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - helper func

    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }

    func removeBarButtonItemOffset(with button: UIButton, offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> UIView {
        let offsetView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        offsetView.bounds = offsetView.bounds.offsetBy(dx: offsetX, dy: offsetY)
        offsetView.addSubview(button)
        return offsetView
    }

    // MARK: - private func

    private func setupBackButton() {
        // FIXME: - 뒤로가기 버튼 커스텀 이미지 추가
    }

    private func setupInteractivePopGestureRecognizer() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let count = self.navigationController?.viewControllers.count else { return false }
        return count > 1
    }
}
