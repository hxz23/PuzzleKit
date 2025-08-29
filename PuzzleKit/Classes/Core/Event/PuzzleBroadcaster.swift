//
//  PuzzleBroadcaster.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2024/1/5.
//

import Foundation

public class PuzzleBroadcaster {
    private var observersDic = [String: Any]()

    private let notificationQueue = DispatchQueue(label: "com.swift.puzzle.event.dispatch.queue", attributes: .concurrent)

    public init() { }

    public func register<T>(_ protocolType: T.Type, observer: T) {
        let key = "\(protocolType)"
        safeSet(key: key, object: observer as AnyObject)
    }

    public func unregister<T>(_ protocolType: T.Type, observer: T) {
        let key = "\(protocolType)"
        safeRemove(key: key, object: observer as AnyObject)
    }

    public func unregister<T>(_ protocolType: T.Type) {
        let key = "\(protocolType)"
        safeRemove(key: key)
    }

    public func notify<T>(_ protocolType: T.Type, block: (T) -> Void) {
        let key = "\(protocolType)"
        guard let objectSet = safeGetObjectSet(key: key) else {
            return
        }

        for observer in objectSet {
            if let observer = observer as? T {
                block(observer)
            }
        }
    }
}

private extension PuzzleBroadcaster {
    func safeSet(key: String, object: AnyObject) {
        notificationQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            if var set = self.observersDic[key] as? WeakObjectSet<AnyObject> {
                set.add(object)
                self.observersDic[key] = set
            } else {
                self.observersDic[key] = WeakObjectSet(object)
            }
        }
    }

    func safeRemove(key: String, object: AnyObject) {
        notificationQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            if var set = self.observersDic[key] as? WeakObjectSet<AnyObject> {
                set.remove(object)
                self.observersDic[key] = set
            }
        }
    }

    func safeRemove(key: String) {
        notificationQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.observersDic.removeValue(forKey: key)
        }
    }

    func safeGetObjectSet(key: String) -> WeakObjectSet<AnyObject>? {
        var objectSet: WeakObjectSet<AnyObject>?
        notificationQueue.sync { [weak self] in
            guard let self = self else { return }
            objectSet = self.observersDic[key] as? WeakObjectSet<AnyObject>
        }
        return objectSet
    }
}
