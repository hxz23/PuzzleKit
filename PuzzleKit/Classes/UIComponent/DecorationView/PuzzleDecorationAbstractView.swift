//
//  PuzzleDecorationAbstractView.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/23.
//

import Foundation

open class PuzzleDecorationAbstractView: UICollectionReusableView {
    open func update(_: PuzzleDecorationAbstractVM?) {}

    override open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attributes = layoutAttributes as? PuzzleDecorationAttributes {
            update(attributes.vm)
        }
    }
}
