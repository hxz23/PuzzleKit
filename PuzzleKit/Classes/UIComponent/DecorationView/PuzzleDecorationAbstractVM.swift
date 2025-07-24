//
//  PuzzleDecorationAbstractVM.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/23.
//

import Foundation

open class PuzzleDecorationAbstractVM {
    open func decorationViewClass() -> PuzzleDecorationAbstractView.Type {
        return PuzzleDecorationAbstractView.self
    }

    public init() {}
}
