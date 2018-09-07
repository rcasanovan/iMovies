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
        addObservers()
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
        searchVC.presenter = IMSearchPresenter(view: searchVC)
        
        self.window?.rootViewController = searchVC
        self.window?.makeKeyAndVisible()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector:#selector(reachabilityStatusChanged), name: NSNotification.Name.FXReachabilityStatusDidChange, object: nil)
    }
    
    @objc private func reachabilityStatusChanged(notification: Notification) {
        guard let reachability = notification.object as? FXReachability else {
            return
        }
        
        showReachabilityMessage(!reachability.isReachable)
    }
    
    private func showReachabilityMessage(_ show: Bool) {
        guard let rootViewController = UIApplication.shared.windows[0].rootViewController else {
            return
        }
        
        if show, let _ = rootViewController.presentedViewController as? IMGeneralMessageViewController {
            return
        }
        
        if show {
            let generalMessageViewController = IMGeneralMessageViewController()
            generalMessageViewController.modalTransitionStyle = .coverVertical
            generalMessageViewController.modalPresentationStyle = .overCurrentContext
            generalMessageViewController.presenter = IMGeneralMessagePresenter(view: generalMessageViewController, type: .NoInternetConnection)
            rootViewController.present(generalMessageViewController, animated: true, completion: nil)
        } else {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}

