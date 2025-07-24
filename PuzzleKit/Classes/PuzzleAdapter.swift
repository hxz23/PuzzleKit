//
//  PuzzleAdapter.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation
import UIKit

public class PuzzleAdapter {
    public typealias Completion = () -> Void

    public weak var collectionView: UICollectionView?

    public let bridge = PuzzleCollectionViewBridge()

    public var eventBus = PuzzleEventBus()

    public var logicComponents = [PuzzleLogicComponent]() {
        didSet {
            for logicComponent in logicComponents {
                logicComponent.eventBus = eventBus
                logicComponent.adapter = self
                if logicComponent.didSetup == false {
                    logicComponent.setup()
                }
            }
        }
    }

    static func collectionView(_ adapter: PuzzleAdapter) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: adapter.bridge.layout)
        adapter.bind(view)
        return view
    }

    // MARK: - public method

    public func scroll(to viewModel: PuzzleViewModelSizeProtocol, animated: Bool = false, offsetY: CGFloat = 0) {
        DispatchQueue.main.async {
            guard let targetFrame = viewModel.frameInCollection, let collectionView = self.collectionView else {
                return
            }

            var targetY: CGFloat
            if targetFrame.minY + collectionView.frame.height > collectionView.contentSize.height {
                targetY = collectionView.contentSize.height - collectionView.frame.height
                if targetY < 0 {
                    targetY = 0
                }
            } else {
                targetY = targetFrame.minY
            }
            targetY += offsetY
            collectionView.setContentOffset(.init(x: 0, y: targetY), animated: animated)
        }
    }

    public func scroll(to contentOffset: CGPoint, animated: Bool = false) {
        DispatchQueue.main.async {
            guard let collectionView = self.collectionView else {
                return
            }

            var targetY: CGFloat
            if contentOffset.y + collectionView.frame.height > collectionView.contentSize.height {
                targetY = collectionView.contentSize.height - collectionView.frame.height
                if targetY < 0 {
                    targetY = 0
                }
            } else {
                targetY = contentOffset.y
            }
            collectionView.setContentOffset(.init(x: 0, y: targetY), animated: animated)
        }
    }

    public func reload(completion: @escaping (Completion)) {
        DispatchQueue.main.async {
            self.bridge.reload(completion: completion)
        }
    }

    public func performBatchUpdate(_: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        // fix crash: https://bugly.qq.com/v2/crash-reporting/crashes/692b559663/17002?pid=2&crashDataType=unSystemExit

//        if let pre = self.collectionView?.numberOfSections, pre == bridge.currentSectionCount() {
//            DispatchQueue.main.async {
//                self.collectionView?.performBatchUpdates({ [weak self] in
//                    updates?()
//                    self?.bridge.reload {
//
//                    }
//                }, completion: completion)
//            }
//        } else {
//        DispatchQueue.main.async { [weak self] in
//            self?.bridge.reload {}
//        }
//        }
        reload {
            completion?(true)
        }
    }

    // MARK: - private method

    func bind(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        bridge.collectionView = collectionView
        bridge.adapter = self

        collectionView.dataSource = bridge
        collectionView.delegate = bridge
    }

    func puzzleViewDidScroll(scrollView: UIScrollView) {
        eventBus.broadcaster.notify(PuzzleAdapterEvent.self) {
            $0.puzzleViewDidScroll(scrollView)
        }
    }

    // 刷新相关
    public var supportRefresh: Bool {
        if logicComponents.count > 0 {
            var support = false
            for cp in logicComponents where cp.supportRefresh == true {
                support = true
                break
            }

            return support
        }
        return false
    }

    public var supportLoadMore: Bool {
        if logicComponents.count > 0 {
            var support = false
            for cp in logicComponents where cp.supportLoadMore == true {
                support = true
                break
            }

            return support
        }
        return false
    }

    public func refreshAction() {
        logicComponents.forEach { $0.refreshAction() }
    }

    public func loadMoreAction() {
        logicComponents.forEach { $0.loadMoreAction() }
    }

    public func endLoading(withNoData: Bool = false) {
        eventBus.broadcaster.notify(PuzzleAdapterEvent.self) {
            $0.endLoading(withNoData: withNoData)
        }
    }

    public func updateSupportRefreshState() {
        eventBus.broadcaster.notify(PuzzleAdapterEvent.self) {
            $0.updateSupportRefreshState()
        }
    }

//    // MARK: - 截图相关
//
//    public func snapshot() -> UIImage? {
//        collectionView?.snapshot
//    }
}
