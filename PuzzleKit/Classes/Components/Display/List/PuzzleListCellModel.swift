//
//  PuzzleListCellModel.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

open class PuzzleListCellModel: PuzzleBaseCellModel {
    public var height: CGFloat = 0

    override public func viewSize() -> CGSize {
        .init(width: 0, height: height)
    }
}
