//
//  RootReducer.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import ReSwift

struct RootReducer : Reducer {
    
    typealias ReducerStateType = RootState
    
    let movieDetailReducer = MovieDetailReducer()
    
    func handleAction(action: Action, state: RootState?) -> RootState {
        if state == nil {
            return RootState()
        }
        return handleDefaultAction(action: action, state: state)
    }
    
    func handleDefaultAction(action: Action, state: RootState?) -> RootState {
        let movieDetailState: MovieDetailState = movieDetailReducer.handleAction(action: action, state: state?.movieDetailState)

        return RootState(movieDetailState: movieDetailState)
    }
    
}
