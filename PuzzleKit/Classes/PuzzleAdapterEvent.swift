//
//  PuzzleAdapterEvent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2024/1/5.
//

import Foundation

public protocol PuzzleAdapterEvent: AnyObject {
    // MARK: - 刷新相关

    func endLoading(withNoData: Bool)

    func updateSupportRefreshState()

    // MARK: - CollectionView Delegate

    func puzzleViewDidScroll(_ scrollView: UIScrollView)
}

public extension PuzzleAdapterEvent {
    // MARK: - 刷新相关

    func endLoading(withNoData _: Bool) {}

    func updateSupportRefreshState() {}

    // MARK: - UIScrollView Delegate

    func puzzleViewDidScroll(_: UIScrollView) {}
}
