//
//  PuzzleLogicComponentWithParam.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/8/13.
//

import Foundation

open class PuzzleLogicComponentWithParam<T>: PuzzleLogicComponent, PuzzleLogicComponentDatasource {
    public var params: T?

    override public init() {
        super.init()
        dataSource = self
    }

    open func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleAbstractUIComponent] {
        []
    }
}
