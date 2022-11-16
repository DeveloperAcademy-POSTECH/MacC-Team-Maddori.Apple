//
//  CustomTabBarController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/14.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
        }
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configUI()
        setupConfiguration()
    }
    
    // MARK: - func
    
    private func setupTabBar() {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.image = ImageLiterals.imgHomeTab
        homeViewController.tabBarItem.title = TextLiteral.homeTabTitle
        
        let myFeedbackViewController = UINavigationController(rootViewController: MyFeedbackViewController())
        myFeedbackViewController.tabBarItem.image = ImageLiterals.imgDocsTab
        myFeedbackViewController.tabBarItem.title = TextLiteral.myFeedbackTabTitle
        
        let myReflectionViewController = UINavigationController(rootViewController: MyReflectionViewController())
        myReflectionViewController.tabBarItem.image = ImageLiterals.imgPersonTab
        myReflectionViewController.tabBarItem.title = TextLiteral.myReflectionTabTitle
        
        let viewControllers = [homeViewController, myFeedbackViewController, myReflectionViewController]
        
        self.setViewControllers(viewControllers, animated: false)
    }
    
    private func setupConfiguration() {
        self.navigationItem.hidesBackButton = true
    }
    
    private func configUI() {
        tabBar.tintColor = .blue200
        tabBar.backgroundColor = .backgroundWhite
        tabBar.unselectedItemTintColor = .gray300
        
        tabBar.layer.cornerRadius = 8
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.clearShadow()
        tabBar.makeShadow(color: .black, opacity: 0.15, offset: .zero, radius: 1)
    }
}
