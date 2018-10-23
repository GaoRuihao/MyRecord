//
//  SecondViewController.swift
//  MyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit
import AudioToolbox

class TodoListViewController: UIViewController {

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildSubviews()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        tableView.addGestureRecognizer(doubleTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(headerViewDidChanged), name: .headerViewDidShowingNotification, object: nil)
        
        let store = RecordStore.shared
        for _ in 0...10 {
            let newCount = store.count + 1
            let title = "Record Item \(newCount)"
            store.append(item: .init(title: title))
        }
        tableView.reloadData()
    }

    func buildSubviews() {
        navigationItem.leftBarButtonItem = nil
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        tableView = UITableView(frame: view.bounds, style: .grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        view.addSubview(tableView);
        
        let headerView = EditHeaderView(frame: CGRect(x: 0, y: -100, width: view.width, height: 80))
        tableView.headerView = headerView
        headerView.pullingDidEnd = {
            let addVC = AddTodoViewController()
            self.navigationController?.pushViewController(addVC, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        let vc = BaseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func doubleTapGesture(_ tap: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func headerViewDidChanged() {
        
    }

}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
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


