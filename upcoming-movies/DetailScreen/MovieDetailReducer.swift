//
//  MovieDetailReducer.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import ReSwift

struct MovieDetailReducer: Reducer {
    
    typealias ReducerStateType = MovieDetailState
    
    func handleAction(action: Action, state: MovieDetailState?) -> MovieDetailState {
        if state == nil {
            return MovieDetailState()
        }
        
        switch action {
        case let action as SetMovieDetailAction:
            return setMovie(state: state!, action: action)
        default:
            return state!
        }
    }
    
    fileprivate func setMovie(state: MovieDetailState, action: SetMovieDetailAction) -> MovieDetailState {
        var state = state
        
        let movie = action.movie
        
        state.name = movie.name ?? ""
        state.genre = movie.genre ?? ""
        state.releaseDate = movie.releaseDate ?? ""
        state.overview = movie.overview ?? ""
        state.movieImage = action.image
        
        return state
    }
    
}
