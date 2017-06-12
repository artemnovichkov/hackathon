//
//  AppDelegate.swift
//  Hackathon
//
//  Created by Artem Novichkov on 10/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import CoreSpotlight

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainViewController: MainViewController? {
        return ((window?.rootViewController as? UINavigationController)?.viewControllers.first as? MainViewController)
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: MainViewController())
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        RealmService.configureRealm()
        if let url = launchOptions?[UIApplicationLaunchOptionsKey.url] as? URL {
            handleURL(url)
        }
        return true
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        mainViewController?.restoreUserActivityState(userActivity)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        handleURL(url)
        return true
    }
    
    // MARK: - URL Schemes
    
    func handleURL(_ url: URL) {
        if let applicationIdentifier = url.host {
            let userActivity = NSUserActivity(activityType: CSSearchableItemActionType)
            let userInfo = [CSSearchableItemActivityIdentifier: applicationIdentifier]
            userActivity.userInfo = userInfo
            mainViewController?.restoreUserActivityState(userActivity)
        }
    }
}
