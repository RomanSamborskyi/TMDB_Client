//
//  TabBarController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 11.07.2024.
//

import UIKit



class TabBarController: UITabBarController {
    
    //MARK: - property
    let sessionId: String
    private lazy var profileTab = UINavigationController(rootViewController: ProfileModuleBuilder.build(sessionId: sessionId))
    private lazy var moviesTab = UINavigationController(rootViewController: MoviesViewController())
    //MARK: - lifecycle
    
    init(sessionId: String) {
        self.sessionId = sessionId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor.black
        setupLayout()
    }
}
//MARK: - UILayout
private extension TabBarController {
    func setupLayout() {
        self.viewControllers = [moviesTab, profileTab]
        setupTabs()
    }
    func setupTabs() {
        profileTab.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 0)
        moviesTab.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "popcorn.fill"), tag: 1)
    }
}
