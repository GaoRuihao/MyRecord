//
//  NotificationCenter.swift
//  MyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

extension Notification {
    struct UserInfoKey<ValueType>: Hashable {
        let key: String
    }
    
    func getUserInfo<T>(for key: Notification.UserInfoKey<T>) -> T {
        return userInfo![key] as! T
    }
}
extension Notification.Name {
    static let recordStoreDidChangedNotification = Notification.Name(rawValue: "com.gaorhao.app.RecordStoreDidChangedNotification")
}
extension Notification.UserInfoKey {
    static var recordStoreDidChangedChangeBehaviorKey: Notification.UserInfoKey<RecordStore.ChangeBehavior> {
        return Notification.UserInfoKey(key: "com.gaorhao.app.RecordStoreDidChangedNotification.ChangeBehavior")
    }
}
extension NotificationCenter {
    func post<T>(name aName: NSNotification.Name, object anObject: Any?, typedUserInfo aUserInfo: [Notification.UserInfoKey<T> : T]? = nil) {
        post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}
