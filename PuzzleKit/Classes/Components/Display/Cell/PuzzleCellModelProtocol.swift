//
//  PuzzleCellModelProtocol.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public protocol PuzzleCellModelProtocol: AnyObject {
    var adapter: PuzzleCollectionViewAdapter? { get }
    /// weak
    var uiComponent: PuzzleDisplayComponent? { get set }

    func viewSize() -> CGSize

    var frameInCollection: CGRect? { get set }

    var eventBus: PuzzleEventBus? { get set }

    func floatPriority() -> Int

    func isFloat() -> Bool
    
    func createViewClass() -> UICollectionViewCell.Type

    func reload(completion: @escaping (PuzzleCollectionViewAdapter.Completion))
    
    func updateHeight(with context: PuzzleUIComponentContext)
}

public extension PuzzleCellModelProtocol {
    func updateHeight(with context: PuzzleUIComponentContext) { }
}

public struct PuzzleUIComponentContext {
    public let puzzleViewWidth: CGFloat
    public let contentMargin: UIEdgeInsets
    
    public var horizontalMargin: CGFloat {
        return contentMargin.left + contentMargin.right
    }
    
    public var viewWidth: CGFloat {
        puzzleViewWidth - horizontalMargin
    }
}
