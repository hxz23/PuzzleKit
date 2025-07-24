//
//  WeakObject.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2024/1/5.
//

import Foundation

public typealias WeakAnyObject = WeakObject<AnyObject>

public struct WeakObject<T: AnyObject>: Equatable, Hashable {
    private let identifier: ObjectIdentifier

    public weak var object: T?

    public init(_ object: T) {
        self.object = object
        identifier = ObjectIdentifier(object)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier.hashValue)
    }

    public static func == (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

public struct WeakObjectSet<T: AnyObject>: Sequence {
    var objects: Set<WeakObject<T>>

    public init() {
        objects = Set<WeakObject<T>>([])
    }

    public init(_ object: T) {
        objects = Set<WeakObject<T>>([WeakObject(object)])
    }

    public init(_ objects: [T]) {
        self.objects = Set<WeakObject<T>>(objects.map { WeakObject($0) })
    }

    public var allObjects: [T] {
        #if swift(>=4.1)
            return objects.compactMap { $0.object }
        #else
            return objects.flatMap { $0.object }
        #endif
    }

    public func contains(_ object: T) -> Bool {
        return objects.contains(WeakObject(object))
    }

    public mutating func add(_ object: T) {
        // prevent ObjectIdentifier be reused
        if contains(object) {
            remove(object)
        }
        objects.insert(WeakObject(object))
    }

    public mutating func add(_ objects: [T]) {
        objects.forEach { self.add($0) }
    }

    public mutating func remove(_ object: T) {
        objects.remove(WeakObject<T>(object))
    }

    public mutating func remove(_ objects: [T]) {
        objects.forEach { self.remove($0) }
    }

    public func makeIterator() -> AnyIterator<T> {
        let objects = allObjects
        var index = 0
        return AnyIterator {
            defer { index += 1 }
            return index < objects.count ? objects[index] : nil
        }
    }
}
