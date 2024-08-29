//
//  TabBarController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 11.07.2024.
//

import UIKit



class TabBarController: UITabBarController {
    //MARK: - managers
    private var networkManager = NetworkManager()
    private var imageDownloader = ImageDownloader()
    //MARK: - init property
    let sessionId: String
    let haptic: HapticFeedback
    //MARK: - property
    private lazy var profileTab = UINavigationController(rootViewController: ProfileModuleBuilder.build(sessionId: self.sessionId, networkManager: self.networkManager, imageDownloader: self.imageDownloader, haptic: self.haptic))
    private lazy var moviesTab = UINavigationController(rootViewController: MovieModuleBuilder.build(networkManager: self.networkManager, imageDownloader: self.imageDownloader, haptic: self.haptic, sessionId: self.sessionId))
    private lazy var listsTab = UINavigationController(rootViewController: ListsModuleBuilder.build(networkManager: self.networkManager, imageDownloader: self.imageDownloader, sessionId: self.sessionId, haptic: self.haptic))
    private lazy var watchListTab = UINavigationController(rootViewController: WatchlistModuleBuilder.build(networkManager: self.networkManager, imageDownloader: self.imageDownloader, haptic: self.haptic, sessionId: self.sessionId))
    //MARK: - lifecycle
    init(sessionId: String, haptic: HapticFeedback) {
        self.sessionId = sessionId
        self.haptic = haptic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.overrideUserInterfaceStyle = .dark
        self.tabBar.tintColor = UIColor.white
        setupLayout()
    }
}
//MARK: - UILayout
private extension TabBarController {
    func setupLayout() {
        self.viewControllers = [moviesTab, watchListTab, listsTab, profileTab]
        setupTabs()
    }
    func setupTabs() {
        profileTab.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 0)
        moviesTab.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "popcorn.fill"), tag: 1)
        listsTab.tabBarItem = UITabBarItem(title: "Lists", image: UIImage(systemName: "list.star"), tag: 2)
        watchListTab.tabBarItem = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "stopwatch.fill"), tag: 3)
        
    }
}
