//
//  AddToListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit


protocol AddToListInteractorProtocol: AnyObject {
    
}


class AddToListInteractor {
    //MARK: property
    weak var presenter: AddToListPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let listId: Int
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.listId = listId
    }
}
//MARK: - AddToListInteractorProtocol
extension AddToListInteractor: AddToListInteractorProtocol {
    
}

