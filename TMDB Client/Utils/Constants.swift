//
//  Constants.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import UIKit


struct Constants {
    //MARK: - operations strings
    static let account_id: String = "account_id"
    static let access_token: String = "access_token"
    static let sessionKey: String = "session_id"
    static let officialTrailer: String = "Official Trailer"
    static let apiKey: String = TMDB_KEY.key
    
    //MARK: - images names
    static let noWiFiIcon: String = "wifi.slash"
    static let unexpectedErrorIcon: String = "xmark.circle"
    static let emptyImageIcon: String = "image"
    static let rectangleAndMagnifyingGlas: String = "rectangle.and.text.magnifyingglass"
    static let listBulletClipboard: String = "list.bullet.clipboard.fill"
    static let chevronBackward: String = "chevron.backward"
    static let listBullet: String = "list.bullet"
    static let movieClapper: String = "movieclapper"
    static let bookmarkFill: String = "bookmark.fill"
    static let heartFill: String = "heart.fill"
    static let starFill: String = "star.fill"
    //MARK: - labels
    static let noIternetError: String = "No internet connection"
    static let unexpectedErrorTitle: String = "Oops, smth go wrong"
    static let okLabel: String = "Ok"
    static let errorStringLabel: String = "Error"
    static let reviewsLabel: String = "Reviews"
    static let similarMoviesLabel: String = "Similar movies"
    static let noReviewsLabel: String = "No reviews"
    static let emptyListLabel: String = "The list is empty"
    static let mediaTypeMovie: String = "movie"
    static let overviewLabel: String = "Overview"
    static let watchTrailerLabel: String = "Watch trailer"
    static let castAndCrewLabel: String = "Cast & Crew"
    static let namePlaceholder: String = "name placeholder"
    //MARK: - sizes
    
    //MARK: - navigation Bar titles
    static let movies: String = "Movies"
    
    //MARK: - other
    static let joinedSeparator: String = " • "
    
    //MARK: - collection views identifier
    static let moviesCastCollectionViewIdentifier: String = "MoviesCastCollectionView"
    static let topCollectionViewCellIdentifier: String = "TopCollectionViewCell"
    static let topPickerViewCellIdentifier: String = "TopPickerViewCell"
    static let genrePickerCellIdentifier: String = "GenrePickerCell"
    static let moviesReviewCollectionViewCellIdentifier: String = "MoviesReviewCollectionViewCell"
}

