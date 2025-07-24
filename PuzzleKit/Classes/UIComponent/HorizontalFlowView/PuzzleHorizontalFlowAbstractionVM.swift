//
//  PuzzleHorizontalFlowAbstractionVM.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

open class PuzzleHorizontalFlowAbstractionVM: PuzzleViewModelSizeProtocol {
    public var frameInCollection: CGRect?

    public weak var uiComponent: PuzzleAbstractUIComponent?

    public weak var eventBus: PuzzleEventBus?

    /// 使用者自己计算
    public var width: CGFloat = 0

    // component中赋值
    public var height: CGFloat = 0
    var displayWidth: CGFloat = 0

    open func createViewClass() -> UICollectionViewCell.Type {
        UICollectionViewCell.self
    }

    public func viewSize() -> CGSize {
        return .init(width: displayWidth, height: height)
    }

    public func floatPriority() -> Int {
        return 0
    }

    public init() {}
}
