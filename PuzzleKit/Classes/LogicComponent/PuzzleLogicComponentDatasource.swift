//
//  PuzzleLogicComponentDatasource.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2024/1/5.
//

import Foundation

public struct PuzzleContext {
    public let width: CGFloat
}

public protocol PuzzleLogicComponentDatasource: AnyObject {
    func uiComponents(puzzleContext: PuzzleContext) -> [PuzzleAbstractUIComponent]
}
