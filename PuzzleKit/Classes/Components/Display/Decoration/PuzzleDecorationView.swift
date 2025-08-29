//
//  PuzzleDecorationView.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/23.
//

import Foundation

class PuzzleDecorationAttributes: UICollectionViewLayoutAttributes {
    var viewModel: PuzzleDecorationViewModel?
}

open class PuzzleDecorationView: UICollectionReusableView {
    open func update(_: PuzzleDecorationViewModel?) { }

    override open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attributes = layoutAttributes as? PuzzleDecorationAttributes {
            update(attributes.viewModel)
        }
    }
}

open class PuzzleDecorationViewModel {
    open func decorationViewClass() -> PuzzleDecorationView.Type {
        return PuzzleDecorationView.self
    }

    public init() { }
}
