//
//  MoviesCollectionReducer.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 26/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import ReSwift

struct MoviesCollectionReducer: Reducer {
    
    typealias ReducerStateType = MoviesCollectionState
    
    func handleAction(action: Action, state: MoviesCollectionState?) -> MoviesCollectionState {
        if state == nil {
            return MoviesCollectionState()
        }
        
        switch action {
        case let action as SetSearchBarText:
            return setSearchBarText(state: state!, action: action)
        default:
            return state!
        }
    }
    
    fileprivate func setSearchBarText(state: MoviesCollectionState, action: SetSearchBarText) -> MoviesCollectionState {
        var state = state
        state.searchBarText = action.text
        return state
    }
    
}
