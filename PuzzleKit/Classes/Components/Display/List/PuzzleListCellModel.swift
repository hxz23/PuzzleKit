//
//  PuzzleListCellModel.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

open class PuzzleListCellModel: PuzzleCellModelProtocol {
    public var frameInCollection: CGRect?

    public weak var uiComponent: PuzzleDisplayComponent?

    public weak var eventBus: PuzzleEventBus?

    public var height: CGFloat = 0

    public var floatPriorityValue = 0

    open func createViewClass() -> UICollectionViewCell.Type {
        UICollectionViewCell.self
    }

    public func viewSize() -> CGSize {
        .init(width: 0, height: height)
    }

    open func floatPriority() -> Int {
        return floatPriorityValue
    }

    public init() { }
}
