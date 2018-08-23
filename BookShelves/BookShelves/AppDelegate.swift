//
//  AppDelegate.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/21/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        gbaAuthClient.resetAuthorization()
        
        if let authState = gbaAuthClient.authorization?.authState, authState.isAuthorized {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initController = storyboard.instantiateViewController(withIdentifier: "InitialView")
            self.window?.rootViewController = initController
            self.window?.makeKeyAndVisible()
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GoogleBooksAuthorizationClient.shared.resumeAuthorizationFlow(with: url)
    }
    
    
    var gbaAuthClient = GoogleBooksAuthorizationClient()
}

