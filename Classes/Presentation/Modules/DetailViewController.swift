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
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private let application: App
    
    var favouriteHandler: ((App) -> Void)?
    var deleteHandler: ((App) -> Void)?
    
    init(application: App) {
        self.application = application
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        label.text = "Name: \(application.name!),\nRank: \(application.rank), \nScore: \(application.score)"
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.configureFrame { maker in
            maker.sizeThatFits(size: view.frame.size)
            maker.center()
        }
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        return actionItems()
    }
    
    func actionItems() -> [UIPreviewActionItem] {
        let favouriteAction = UIPreviewAction(title: "⭐️ Add to Favourite", style: .default) { [unowned self] action, controller in
            self.favouriteHandler?(self.application)
        }
        let deleteAction = UIPreviewAction(title: "❌ Stop Tracking", style: .destructive) { [unowned self] action, controller in
            self.deleteHandler?(self.application)
        }
        let group = UIPreviewActionGroup(title: "Custom actions", style: .default, actions: [favouriteAction, deleteAction])
        return [group]
    }
}
