//
//  ListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsRouterProtocol: AnyObject {
    func navigateToList(with id: Int, networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback)
    func addList(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback)
}

class ListsRouter {
    //MARK: - property
    weak var view: ListsViewController?
}
//MARK: - ListsRouterProtocol
extension ListsRouter: ListsRouterProtocol {
    func addList(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback) {
        let addListVC = AddListModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic)
        view?.navigationController?.present(addListVC, animated: true)
    }
    func navigateToList(with id: Int, networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback) {
        let detailVC = ListsDetailModuleBuilder.build(list: id, networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic)
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
