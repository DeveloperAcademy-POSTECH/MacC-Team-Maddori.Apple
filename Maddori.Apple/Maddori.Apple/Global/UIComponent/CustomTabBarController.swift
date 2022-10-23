//
//  CustomTabBarController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/23.
//

import UIKit

import SnapKit

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.title = "홈"
        
        let containerVC = AddFeedbackContentViewController()
        containerVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        containerVC.tabBarItem.title = "보관함"
        
        let myVC = JoinTeamViewController()
        myVC.tabBarItem.image = UIImage(systemName: "person.fill")
        myVC.tabBarItem.title = "나의 회고"
        
        let viewControllers = [homeVC, containerVC, myVC]
        self.setViewControllers(viewControllers, animated: true)
    }
    
    // MARK: - func
    
    private func setupTabBar() {
        tabBar.tintColor = .blue200
        tabBar.backgroundColor = .white
        
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
        tabBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }
}
