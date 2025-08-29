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

    var PuzzleCollectionViewAdapter: PuzzleCollectionViewAdapter? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kAdapter, newValue, .OBJC_ASSOCIATION_RETAIN)
            PuzzleCollectionViewAdapter?.bind(self)
        }

        get {
            objc_getAssociatedObject(self, &AssociatedKeys.kAdapter) as? PuzzleCollectionViewAdapter
        }
    }
}
