//
//  UICollectionView+Puzzle.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

extension UICollectionView {
    private enum AssociatedKeys {
        static var kAdapter = "kAdapter"
    }

    var puzzleAdapter: PuzzleAdapter? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kAdapter, newValue, .OBJC_ASSOCIATION_RETAIN)
            puzzleAdapter?.bind(self)
        }

        get {
            objc_getAssociatedObject(self, &AssociatedKeys.kAdapter) as? PuzzleAdapter
        }
    }
}
