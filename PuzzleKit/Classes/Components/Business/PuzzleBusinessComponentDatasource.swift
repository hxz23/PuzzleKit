//
//  PuzzleBusinessComponentDatasource.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2024/1/5.
//

import Foundation

public struct PuzzleContext {
    public let width: CGFloat
}

public protocol PuzzleBusinessComponentDatasource: AnyObject {
    func uiComponents(puzzleContext: PuzzleContext) -> [PuzzleDisplayComponent]
}
