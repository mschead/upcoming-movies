//
//  AppDelegate.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 22/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import UIKit
import ReSwift

var mainStore: Store<RootState>!
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // initialize RootState of the application
        mainStore = Store(reducer: RootReducer(), state: RootState())
        
        return true
    }

}

