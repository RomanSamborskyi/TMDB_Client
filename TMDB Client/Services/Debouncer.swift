//
//  Debouncer.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 03.09.2024.
//

import Foundation


actor Debouncer {
    
    private var task: Task<Void, Never>?
    
    func debounce(action: @escaping ()->Void) {
        task?.cancel()
        
        task = Task {
           try? await Task.sleep(nanoseconds: 2_000_000_000)
            action()
        }
    }
}
