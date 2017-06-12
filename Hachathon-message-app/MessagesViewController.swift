//
//  MessagesViewController.swift
//  HackathonMessageApp
//
//  Created by Nikita Ermolenko on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import Messages
import RealmSwift

fileprivate extension Results {
    var array: [T] {
        var objects = [T]()
        forEach { object in
            objects.append(object)
        }
        return objects
    }
}

class MessagesViewController: MSMessagesAppViewController {
    
    fileprivate var apps = [App]()

    override func viewDidLoad() {
        super.viewDidLoad()

        RealmService.configureRealm()
        
        let realm = try! Realm()
        apps = realm.objects(App.self).array
        if apps.isEmpty {
            AppService().loadApps(completion: { apps in
                self.apps = apps
            })
        }
    }

    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }

    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.willTransition(to: presentationStyle)
        removeAllChildViewControllers()
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.didTransition(to: presentationStyle)
        
        guard let conversation = activeConversation else {
            fatalError("Expected an active converstation")
        }
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    // MARK: Child view controller presentation
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        let controller: UIViewController
        if presentationStyle == .compact {
            let compactedController = compactedViewController()
            compactedController.delegate = self
            compactedController.apps = apps
            controller = compactedController
        }
        else {
            let extendedVieController = extendedViewController()
            extendedVieController.delegate = self
            extendedVieController.apps = apps
            controller = extendedVieController
        }
        
        removeAllChildViewControllers()
        addChildViewController(controller)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            controller.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        controller.didMove(toParentViewController: self)
    }
    
    // MARK: - Helpers
    
    private func removeAllChildViewControllers() {
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
    }
    
    private func compactedViewController() -> CompactedViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "CompactedViewController") as? CompactedViewController else {
            fatalError("Unable to instantiate a CompactedViewController from the storyboard")
        }
        return controller
    }
    
    private func extendedViewController() -> ExtendedViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "ExtendedViewController") as? ExtendedViewController else {
            fatalError("Unable to instantiate a ExtendedViewController from the storyboard")
        }
        return controller
    }
    
    fileprivate func insertApp(_ app: App) {
        let layout = MSMessageTemplateLayout()
        layout.image = app.image
        layout.imageTitle = app.name
        layout.imageSubtitle = String(app.score)
        
        let session = activeConversation?.selectedMessage?.session ?? MSSession()
        let message = MSMessage(session: session)
        message.layout = layout
        message.summaryText = "Summary text"
        
        activeConversation?.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    // MARK: - Message sending
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
        
        // Use this to clean up state related to the deleted message.
    }
}

extension MessagesViewController: CompactedViewControllerDelegate {
    
    func compactedViewController(_ viewController: CompactedViewController, didPressApplication app: App) {
        insertApp(app)
    }
}

extension MessagesViewController: ExtendedViewControllerDelegate {
    
    func extendedViewController(_ viewController: ExtendedViewController, didPressApplicationAt index: Int) {
        requestPresentationStyle(.compact)
        insertApp(apps[index])
    }
}
