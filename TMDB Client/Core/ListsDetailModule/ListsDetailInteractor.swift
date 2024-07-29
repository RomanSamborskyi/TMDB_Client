//
//  ListsDetailInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import Foundation


protocol ListsDetailInteractorProtocol: AnyObject {
    
}

class ListsDetailInteractor {
    //MARK: - property
    weak var presenter: ListsDetailPresenterProtocol?
    //MARK: - lifecycle
}
//MARK: - ListsDetailInteractorProtocol
extension ListsDetailInteractor: ListsDetailInteractorProtocol {
    
}
