//
//  ListIterator.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsInteratorProtocol: AnyObject {
    
}

class ListsInterator {
    //MARK: - property
    weak var presenter: ListsPresenterProtocol?
}
//MARK: - ListsIteratorProtocol
extension ListsInterator: ListsInteratorProtocol {
    
}
