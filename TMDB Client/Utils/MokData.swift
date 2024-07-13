//
//  MokData.swift
//  UIKit practice
//
//  Created by Roman Samborskyi on 18.03.2024.
//

import Foundation


class DeveloperPreview {
    
    static let instance: DeveloperPreview = DeveloperPreview()
    
    var movie: Movie = Movie(adult: true,
                             backdropPath: "kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg",
                             genreIDS: [18,80],
                             genres: [],
                             id: 278,
                             originalLanguage: "en",
                             originalTitle: "The Shawshank Redemption",
                             overview: "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
                             popularity: 139.421,
                             posterPath: "q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
                             releaseDate: "1994-09-23",
                             runtime: 118,
                             title: "The Shawshank Redemption",
                             video: true,
                             voteAverage: 8.711,
                             voteCount: 25398)
    
    var action: Genre = Genre(id:28, name: "Action")
}
