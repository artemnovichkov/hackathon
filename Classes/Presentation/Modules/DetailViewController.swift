//
//  DetailViewController.swift
//  Hackathon
//
//  Created by Artem Novichkov on 10/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import Framezilla

class DetailViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let application: Application
    
    init(application: Application) {
        self.application = application
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        label.text = application.title
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.configureFrame { maker in
            maker.sizeToFit()
            maker.center()
        }
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        return actionItems()
    }
    
    func actionItems() -> [UIPreviewActionItem] {
        let favouriteAction = UIPreviewAction(title: "⭐️ Add to Favourite", style: .default) { action, controller in
            print("Added")
        }
        let deleteAction = UIPreviewAction(title: "❌ Stop Tracking", style: .destructive) { action, controller in
            print("Deleted")
        }
        let group = UIPreviewActionGroup(title: "Custom actions", style: .default, actions: [favouriteAction, deleteAction])
        return [group]
    }
}
