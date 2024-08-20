//
//  AddListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit


protocol AddListInteractorProtocol: AnyObject {
    
}


class AddListInteractor {
    //MARK: - property
    weak var presenter: AddListPresenterProtocol?
    //MARK: - lifecycle
}
//MARK: - AddListInteractorProtocol
extension AddListInteractor: AddListInteractorProtocol {
    
}
