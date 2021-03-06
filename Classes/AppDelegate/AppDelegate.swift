//
//  AppDelegate.swift
//  Hackathon
//
//  Created by Artem Novichkov on 10/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import UserNotifications
import CoreSpotlight

// swiftlint:disable line_length
// swiftlint:disable force_try

extension UIUserNotificationType {
    
    @available(iOS 10.0, *)
    func authorizationOptions() -> UNAuthorizationOptions {
        var options: UNAuthorizationOptions = []
        if contains(.alert) {
            options.formUnion(.alert)
        }
        if contains(.sound) {
            options.formUnion(.sound)
        }
        if contains(.badge) {
            options.formUnion(.badge)
        }
        return options
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
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
        
        if #available(iOS 10.0, *) {
            registerForNotifications(types: [.alert, .sound, .badge])
            scheduleNotification(identifier: "HackAlarm",
                                 title: "Notification",
                                 body: "This is local notification message",
                                 date: Date().addingTimeInterval(10))
        }
        else {
            // Fallback on earlier versions
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
    
    @available(iOS 10.0, *)
    func registerForNotifications(types: UIUserNotificationType) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let options = types.authorizationOptions()
        center.requestAuthorization(options: options) { (granted, _) in
            if granted {
                print("⭐️ Access granted")
            }
        }
    }
    
    @available(iOS 10.0, *)
    func scheduleNotification(identifier: String,
                              title: String,
                              body: String,
                              date: Date) {
        let center = UNUserNotificationCenter.current()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: date)
        
        let content = UNMutableNotificationContent()
        content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1)
        content.title = title
        content.body = body
        content.categoryIdentifier = "Homer"
        
        let attachmentURL = URL(fileURLWithPath: Bundle.main.path(forResource: "hsk", ofType: "gif")!)
        let attachment = try! UNNotificationAttachment(identifier: attachmentURL.lastPathComponent, url: attachmentURL, options: nil)
        content.attachments = [attachment]
        
        let showMoreAction = UNNotificationAction(identifier: "showMore", title: "Подробнее", options: [])
        let category = UNNotificationCategory(identifier: "Homer", actions: [showMoreAction], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("⭐️ Local notification succeeded")
            }
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
        print("⭐️ Notification will be presented")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("⭐️ Received notification response")
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

// swiftlint:enable force_try
// swiftlint:enable line_length
