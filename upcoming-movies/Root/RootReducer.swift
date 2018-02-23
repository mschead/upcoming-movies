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
    
//    let articleListingReducer = ArticleListingReducer()
//    let articleDetailReducer = ArticleDetailReducer()
    
    func handleAction(action: Action, state: RootState?) -> RootState {
        if state == nil {
            return RootState()
        }
        return handleDefaultAction(action: action, state: state)
    }
    
    func handleDefaultAction(action: Action, state: RootState?) -> RootState {
//        let articleListingState: ArticleListingState = articleListingReducer.handleAction(action: action, state: state?.articleListingState)
//        let articleDetailState: ArticleDetailState = articleDetailReducer.handleAction(action: action, state: state?.articleDetailState)
//
//        return RootState(articleListingState: articleListingState, articleDetailState: articleDetailState)
        return RootState()
    }
    
}
