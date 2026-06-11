//
//  TabBarController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 11.07.2024.
//

import UIKit


class TabBarController: UITabBarController {
    //MARK: - managers
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let keychain: KeyChainManager
    //MARK: - init property
    let sessionId: String
    let haptic: HapticFeedback
    //MARK: - property
    private lazy var profileTab = UINavigationController(rootViewController: ProfileModuleBuilder.build(sessionId: self.sessionId, networkManager: self.networkManager, imageDownloader: self.imageDownloader, haptic: self.haptic, keychain: self.keychain))
    private lazy var moviesTab = UINavigationController(rootViewController: MovieModuleBuilder.build(networkManager: self.networkManager, imageDownloader: self.imageDownloader, haptic: self.haptic, sessionId: self.sessionId, keychain: keychain))
    private lazy var listsTab = UINavigationController(rootViewController: ListsModuleBuilder.build(networkManager: self.networkManager, imageDownloader: self.imageDownloader, sessionId: self.sessionId, haptic: self.haptic, keychain: self.keychain))
    private lazy var watchListTab = UINavigationController(rootViewController: WatchlistModuleBuilder.build(networkManager: self.networkManager, imageDownloader: self.imageDownloader, haptic: self.haptic, sessionId: self.sessionId, keychain: self.keychain))
    private lazy var searchTab = UINavigationController(rootViewController: SearchModuleBuilder.build(networkManager: self.networkManager, imageDownloader: self.imageDownloader, haptic: self.haptic, sessionId: self.sessionId))
    //MARK: - lifecycle
    init(sessionId: String, haptic: HapticFeedback, networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager) {
        self.sessionId = sessionId
        self.haptic = haptic
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.keychain = keychain
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 26.0, *) {
            self.navigationItem.hidesBackButton = false
        } else {
            self.navigationItem.hidesBackButton = true
        }
        self.overrideUserInterfaceStyle = .dark
        self.tabBar.tintColor = UIColor.white
        setupLayout()
    }
}
//MARK: - UILayout
private extension TabBarController {
    func setupLayout() {
        self.viewControllers = [moviesTab, searchTab, watchListTab, listsTab, profileTab]
        setupTabs()
    }
    func setupTabs() {
        profileTab.tabBarItem = UITabBarItem(title: Constants.profileTabLabel, image: UIImage(systemName: Constants.profileTabIconName), tag: 0)
        moviesTab.tabBarItem = UITabBarItem(title: Constants.moviesTabLabel, image: UIImage(systemName: Constants.moviesTabIconName), tag: 1)
        listsTab.tabBarItem = UITabBarItem(title: Constants.listsTabLabel, image: UIImage(systemName: Constants.listsTabIconName), tag: 2)
        watchListTab.tabBarItem = UITabBarItem(title: Constants.watchListTabLabel, image: UIImage(systemName: Constants.watchListTabIconName), tag: 3)
        searchTab.tabBarItem = UITabBarItem(title: Constants.searchTabLabel, image: UIImage(systemName: Constants.searchTabIconName), tag: 4)
    }
}
