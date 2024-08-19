//
//  ListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsRouterProtocol: AnyObject {
    func navigateToList(with id: Int, networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String)
}

class ListsRouter {
    //MARK: - property
    weak var view: ListsViewController?
}
//MARK: - ListsRouterProtocol
extension ListsRouter: ListsRouterProtocol {
    func navigateToList(with id: Int, networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String) {
        let detailVC = ListsDetailModuleBuilder.build(list: id, networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId)
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
