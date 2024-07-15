//
//  WatchListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchListInteractorProtocol: AnyObject {
    
}

class WatchListInteractor {
    //MARK: - property
    weak var presenter: WatchListPresenterProtocol?
}
//MARK: - WatchListInteractorProtocol
extension WatchListInteractor: WatchListInteractorProtocol {
    
}
