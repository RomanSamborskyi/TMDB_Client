//
//  AddToExistListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


protocol AddToExistListInteractorProtocol: AnyObject {
    
}


class AddToExistListInteractor {
    //MARK: - property
    weak var presenter: AddToExiistListPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let listId: Int
    let sessionId: String
    
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int, sessionId: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.listId = listId
        self.sessionId = sessionId
    }
}
//MARK: - AddToExistListInteractorProtocol
extension AddToExistListInteractor: AddToExistListInteractorProtocol {
    
}
