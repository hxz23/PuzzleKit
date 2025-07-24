//
//  PuzzleViewModelSizeProtocol.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public protocol PuzzleViewModelProtocol: AnyObject {
    var eventBus: PuzzleEventBus? { get set }
    var uiComponent: PuzzleAbstractUIComponent? { get set }
}

public protocol PuzzleViewModelSizeProtocol: PuzzleViewModelProtocol {
    /// weak
    var uiComponent: PuzzleAbstractUIComponent? { get set }

    func viewSize() -> CGSize

    func createViewClass() -> UICollectionViewCell.Type

    var eventBus: PuzzleEventBus? { get set }

    func floatPriority() -> Int

    var frameInCollection: CGRect? { get set }
}

public extension PuzzleViewModelSizeProtocol {
    func isFloat() -> Bool {
        floatPriority() > 0
    }

    var adapter: PuzzleAdapter? {
        uiComponent?.logicComponent?.adapter
    }
}

public extension PuzzleViewModelProtocol {
    func reload(completion: @escaping (PuzzleAdapter.Completion)) {
        uiComponent?.logicComponent?.adapter?.reload(completion: completion)
    }

    func performBatchUpdate(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        uiComponent?.logicComponent?.adapter?.performBatchUpdate(updates, completion: completion)
    }
}
