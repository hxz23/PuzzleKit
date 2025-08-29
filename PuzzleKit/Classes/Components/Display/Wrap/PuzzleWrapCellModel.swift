//
//  PuzzleWrapCellModel.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

open class PuzzleWrapCellModel: PuzzleBaseCellModel {
    /// 使用者自己计算
    public var width: CGFloat = 0

    // component中赋值
    public var height: CGFloat = 0
    
    var displayWidth: CGFloat = 0

    override public func viewSize() -> CGSize {
        return .init(width: displayWidth, height: height)
    }
}
