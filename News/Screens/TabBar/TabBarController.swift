//
//  TabBarController.swift
//  News
//
//  Created by Muhammed Yılmaz on 4.06.2025.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

}

// MARK: - Private Methods
private extension TabBarController {
    func setupTabs() {
        let homeVC = createNav(
            with: "News",
            and: UIImage(systemName: "newspaper.fill"),
            viewController: NewsViewController()
        )
        let settingsVC = createNav(
            with: "Settings",
            and: UIImage(systemName: "gear"),
            viewController: SettingsViewController()
        )
        
        setViewControllers([homeVC, settingsVC], animated: false)
    }
    
    func createNav(with title: String,and image: UIImage?,viewController: UIViewController) -> UINavigationController {
        let controller = UINavigationController(rootViewController: viewController)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        viewController.title = title
        controller.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.largeTitleDisplayMode = .always
        return controller
    }
}

