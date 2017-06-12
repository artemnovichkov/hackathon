//
//  AppDelegate.swift
//  Hackathon
//
//  Created by Artem Novichkov on 10/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import UserNotifications

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
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
        
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
        let attachmentURL = URL(fileURLWithPath: Bundle.main.path(forResource: "hsk", ofType: "gif")!)
        let attachment = try! UNNotificationAttachment(identifier: attachmentURL.lastPathComponent, url: attachmentURL, options: nil)
        content.attachments = [attachment]
        
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
    }
}

// swiftlint:enable force_try
// swiftlint:enable line_length
