//
//  SplashVC.swift
//  News
//
//  Created by Muhammed Yılmaz on 28.05.2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Properties
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "newspaper.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "Smith News"
        label.textColor = .label
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        navigationToTabBar()
    }

}

// MARK: - Private Methods
private extension SplashViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(iconImage)
        view.addSubview(newsLabel)
    }
    
    func configureLayout() {
        iconImage.setupAnchors(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor,
            width: 216,
            height: 216
        )
        newsLabel.setupAnchors(
            top: iconImage.bottomAnchor,
            paddingTop: 8,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
    }
    func navigationToTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            let tabBarController = TabBarController()
            sceneDelegate.window?.rootViewController = tabBarController
        }
    }
}


#Preview {
    SplashViewController()
        
}
