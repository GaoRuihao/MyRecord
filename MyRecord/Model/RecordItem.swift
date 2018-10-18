//
//  RecordItem.swift
//  MyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

struct RecordItem {
    typealias ItemId = UUID
    
    let id: ItemId
    let title: String
    
    init(title: String) {
        self.id = ItemId()
        self.title = title
    }
}

extension RecordItem: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
}
extension RecordItem: Equatable {
    public static func == (lhs: RecordItem, rhs: RecordItem) -> Bool {
        return lhs.id == rhs.id
    }
}

class RecordStore {
    
    enum ChangeBehavior {
        case add([Int])
        case remove([Int])
        case reload
    }
    
    static let shared = RecordStore()
    
    static func diff(original: [RecordItem], now: [RecordItem]) -> ChangeBehavior {
        let originalSet = Set(original)
        let nowSet = Set(now)
        
        if originalSet.isSubset(of: nowSet) { // Appended
            let added = nowSet.subtracting(originalSet)
            let indexes = added.compactMap { now.index(of: $0) }
            return .add(indexes)
        } else if (nowSet.isSubset(of: originalSet)) { // Removed
            let removed = originalSet.subtracting(nowSet)
            let indexes = removed.compactMap { original.index(of: $0) }
            return .remove(indexes)
        } else { // Both appended and removed
            return .reload
        }
    }
    
    private var items: [RecordItem] = [] {
        didSet {
            let behavior = RecordStore.diff(original: oldValue, now: items)
            NotificationCenter.default.post(
                name: .recordStoreDidChangedNotification,
                object: self,
                typedUserInfo: [.recordStoreDidChangedChangeBehaviorKey: behavior]
            )
        }
    }
    
    private init() {}
    
    func append(item: RecordItem) {
        items.append(item)
    }
    
    func append(newItems: [RecordItem]) {
        items.append(contentsOf: newItems)
    }
    
    func remove(item: RecordItem) {
        guard let index = items.index(of: item) else { return }
        remove(at: index)
    }
    
    func remove(at index: Int) {
        items.remove(at: index)
    }
    
    func edit(original: RecordItem, new: RecordItem) {
        guard let index = items.index(of: original) else { return }
        items[index] = new
    }
    
    var count: Int {
        return items.count
    }
    
    func item(at index: Int) -> RecordItem {
        return items[index]
    }
}


