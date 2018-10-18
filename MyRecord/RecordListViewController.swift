//
//  FirstViewController.swift
//  MyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

class RecordListViewController: UIViewController {
    
    private var tableView: UITableView!
    private var addButton: UIButton!
    private var presentAnimation: BouncePresentAnimation!
    private var dismissAnimation: NormalDismissAnimation!
    private var transitionController: SwipeUpInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildSubviews()
        
        presentAnimation = BouncePresentAnimation()
        dismissAnimation = NormalDismissAnimation()
        transitionController = SwipeUpInteractiveTransition()
        
        NotificationCenter.default.addObserver(self, selector: #selector(recordItemsDidChange(_:)), name: .recordStoreDidChangedNotification, object: nil)
    }
    
    func buildSubviews() {
        let bgImageView = UIImageView.init(frame: view.bounds)
        bgImageView.image = UIImage(named: "recordListBG")
        bgImageView.contentMode = .scaleAspectFill
        
        tableView = UITableView(frame: view.bounds, style: .grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundView = bgImageView
        view.addSubview(tableView);
        
        addButton = UIButton.init(type: .custom)
        addButton.frame = CGRect(x: view.width - 90, y: view.height - 90 - tabBarController!.tabBar.height, width: 80, height: 80)
        addButton.setTitle("添加", for: .normal)
        addButton.layer.cornerRadius = 40
        addButton.backgroundColor = UIColor.green
        addButton.addTarget(self, action: #selector(addBtnAction(_:)), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    @objc func recordItemsDidChange(_ notification: Notification) {
        let behavior = notification.getUserInfo(for: .recordStoreDidChangedChangeBehaviorKey)
        syncTableView(for: behavior)
        updateAddButtonState()
    }
    
    @objc func addBtnAction(_ sender: Any) {
        let addVC = AddRecordViewController()
        addVC.transitioningDelegate = self
        addVC.delegate = self
        self.transitionController.wireToViewController(addVC)
        self.present(addVC, animated: true, completion: nil)
        
        //        let store = RecordStore.shared
        //        let newCount = store.count + 1
        //        let title = "Record Item \(newCount)"
        //
        //        store.append(item: .init(title: title))
    }
    
    private func syncTableView(for behavior: RecordStore.ChangeBehavior) {
        switch behavior {
        case .add(let indexes):
            let indexPathes = indexes.map { IndexPath(row: $0, section: 0) }
            tableView.insertRows(at: indexPathes, with: .automatic)
        case .remove(let indexes):
            let indexPathes = indexes.map { IndexPath(row: $0, section: 0) }
            tableView.deleteRows(at: indexPathes, with: .automatic)
        case .reload:
            tableView.reloadData()
        }
    }
    
    private func updateAddButtonState() {
        addButton?.isEnabled = RecordStore.shared.count < 10
    }
}

extension RecordListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecordStore.shared.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "Cell");
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell");
            
        }
        cell?.textLabel?.text = RecordStore.shared.item(at: indexPath.row).title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let completBtn = UITableViewRowAction.init(style: .default, title: "完成") { (action, indexPath) in
            
        }
        return [completBtn]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //创建“更多”事件按钮
        let unread = UIContextualAction(style: .normal, title: "未读") {
            (action, view, completionHandler) in
            completionHandler(true)
        }
        unread.image = UIImage(named: "")
        unread.backgroundColor = UIColor(red: 52/255, green: 120/255, blue: 246/255,
                                         alpha: 1)
        
        //返回所有的事件按钮
        let configuration = UISwipeActionsConfiguration(actions: [unread])
        return configuration
    }
    
}

extension RecordListViewController: AddRecordViewControllerDelegate {
    func addRecordViewControllerDidClickedDismissButton(viewController: AddRecordViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RecordListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionController.interacting ? transitionController : nil
    }
}

