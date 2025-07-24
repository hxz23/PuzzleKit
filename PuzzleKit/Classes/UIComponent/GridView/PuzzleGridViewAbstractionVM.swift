//
//  PuzzleGridViewAbstractionVM.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/23.
//

import Foundation

open class PuzzleGridViewAbstractionVM: PuzzleViewModelSizeProtocol {
    public var frameInCollection: CGRect?

    public weak var uiComponent: PuzzleAbstractUIComponent?

    public weak var eventBus: PuzzleEventBus?

    // .custom 模式 需要外部计算
    var size = CGSize.zero

    open func createViewClass() -> UICollectionViewCell.Type {
        UICollectionViewCell.self
    }

    public func viewSize() -> CGSize {
        return size
    }

    public func floatPriority() -> Int {
        return 0
    }

    public init() {}
}
