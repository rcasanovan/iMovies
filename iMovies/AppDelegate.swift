//
//  AppDelegate.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        showInitialViewController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

//MARK: - Navigation methods
extension AppDelegate  {
    
    private func showInitialViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let searchVC = IMSearchViewController()
        
        self.window?.rootViewController = searchVC
        self.window?.makeKeyAndVisible()
    }
}

