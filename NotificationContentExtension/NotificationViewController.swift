//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Dmitry Frishbuter on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    @available(iOS 10.0, *)
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

    func didReceive(_ response: UNNotificationResponse,
                    completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if let appURL = URL(string: "hackathon://") {
            extensionContext?.open(appURL, completionHandler: nil)
        }
    }
}
