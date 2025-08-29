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
}
