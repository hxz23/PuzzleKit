//
//  PuzzleBusinessComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

public protocol PuzzleBusinessComponentDatasource: AnyObject {
    func uiComponents(puzzleContext: PuzzleContext) -> [PuzzleDisplayComponent]
}

open class PuzzleBusinessComponent {
    public weak var dataSource: PuzzleBusinessComponentDatasource?

    public weak var adapter: PuzzleCollectionViewAdapter?

    public weak var eventBus: PuzzleEventBus?

    var displayUIComponents = [PuzzleDisplayComponent]()

    public private(set) var isAppeared = false

    public private(set) var didSetup = false

    // MARK: - setup

    public init() { }

    open func setup() {
        didSetup = true
    }

    // MARK: - life cycle

    open func didAppear() {
        isAppeared = true
    }

    open func didDisappear() {
        isAppeared = false
    }

    // MARK: - 刷新相关

    public var supportRefresh = false
    public var supportLoadMore = false

    open func refreshAction() { }

    open func loadMoreAction() { }

    public final func endLoading(withNoData: Bool = false) {
        adapter?.endLoading(withNoData: withNoData)
    }

    // MARK: - 滚动方法

    public func scrollToVisible(_ fixY: CGFloat = 60) {
        guard let frame = displayUIComponents.first?.extra.frameInCollectionView else { return }
        adapter?.collectionView?.setContentOffset(.init(x: 0, y: frame.minY - fixY), animated: true)
    }
}

public extension PuzzleBusinessComponent {
    var isVisible: Bool {
        guard let collectionView = adapter?.collectionView, collectionView.window != nil, let componentInCollection = frameInCollectionView else {
            return false
        }
        let frame = collectionView.bounds
        let offset = collectionView.contentOffset

        return CGRect(x: 0, y: offset.y, width: frame.width, height: frame.height).intersects(componentInCollection)
    }

    var frameInCollectionView: CGRect? {
        if let first = displayUIComponents.first?.extra.frameInCollectionView, let last = displayUIComponents.last?.extra.frameInCollectionView {
            return CGRect(
                x: first.minX,
                y: first.minY,
                width: first.width,
                height: last.maxY - first.minY
            )
        }
        return nil
    }
}
