//
//  PuzzleListViewAbstractionVM.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

open class PuzzleListViewAbstractionVM: PuzzleViewModelSizeProtocol {
    public var frameInCollection: CGRect?

    public weak var uiComponent: PuzzleAbstractUIComponent?

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

    public init() {}
}

public class PuzzleListViewDefaultVM<T, M: AnyObject>: PuzzleListViewAbstractionVM {
    var priority: Int

    override public weak var eventBus: PuzzleEventBus? {
        didSet {
            if let model = model as? PuzzleViewModelProtocol {
                if !(model is PuzzleLogicComponent) {
                    model.eventBus = eventBus
                }
            }
        }
    }

    override public weak var uiComponent: PuzzleAbstractUIComponent? {
        didSet {
            if let model = model as? PuzzleViewModelProtocol {
                if !(model is PuzzleLogicComponent) {
                    model.uiComponent = uiComponent
                }
            }
        }
    }

    var strongModel: M?
    public weak var model: M?

    public init(model: M, height: CGFloat, priority: Int = 0, shouldRetain: Bool = false) {
        if shouldRetain {
            strongModel = model
        }
        self.model = model
        self.priority = priority
        super.init()
        self.height = height
    }

    override public func createViewClass() -> UICollectionViewCell.Type {
        // swiftlint:disable:next force_cast
        return T.self as! UICollectionViewCell.Type
    }

    override public func floatPriority() -> Int {
        return priority
    }

    deinit {
//        print("PuzzleListViewDefaultVM<\(T.self),\(M.self)> deinit")
    }
}
