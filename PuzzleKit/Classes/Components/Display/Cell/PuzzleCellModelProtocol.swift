//
//  PuzzleCellModelProtocol.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public protocol PuzzleCellModelProtocol: AnyObject {
    /// weak
    var uiComponent: PuzzleDisplayComponent? { get set }

    func viewSize() -> CGSize

    func createViewClass() -> UICollectionViewCell.Type

    var eventBus: PuzzleEventBus? { get set }

    func floatPriority() -> Int

    var frameInCollection: CGRect? { get set }
}

public extension PuzzleCellModelProtocol {
    func isFloat() -> Bool {
        floatPriority() > 0
    }

    var adapter: PuzzleCollectionViewAdapter? {
        uiComponent?.logicComponent?.adapter
    }
}

public extension PuzzleCellModelProtocol {
    func reload(completion: @escaping (PuzzleCollectionViewAdapter.Completion)) {
        uiComponent?.logicComponent?.adapter?.reload(completion: completion)
    }

    func performBatchUpdate(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        uiComponent?.logicComponent?.adapter?.performBatchUpdate(updates, completion: completion)
    }
}
