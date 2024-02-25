//
//  AddMovieViewModel.swift
//  MoviesApp
//
//  Created by Pokerface on 25.02.2024.
//

import Foundation
import UIKit
import Combine

class AddMovieViewModel {
    
    var movieID: Int?
    
    var subscriptions = Set<AnyCancellable>()
        
    func addMovieToFavorite(listType: ListType, movieID: Int) {
        let credentials = KeychainManager.shared.getCredentials()
        guard let accountID = credentials.accountDetails?.id,
        let sessionID = credentials.sessionID else {
            return
        }
        
        APICaller.addMovieToFavorite(listType: listType, movieID: movieID, accountID: accountID, sessionID: sessionID).sink { isAdded in
            switch isAdded {
            case .finished:
                print("Movie was added to favorites")
            case .failure(let error):
                print("Movie was not added to favorites. Error: \(error)")
            }
        } receiveValue: { _ in
            
        }.store(in: &subscriptions)

    }
}
