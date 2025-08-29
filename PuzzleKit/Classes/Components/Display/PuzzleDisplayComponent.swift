//
//  PuzzleDisplayComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

public protocol PuzzleDisplayComponent: AnyObject {
    // weak
    var logicComponent: PuzzleBusinessComponent? { get set }

    var contentPadding: UIEdgeInsets { get set }

    var contentSize: CGSize { get set }

    var attributesList: [PuzzleDisplayComponentCellAttributes] { get set }

    var decorateViewModel: PuzzleDecorationViewModel? { get set }

    var decorateViewPadding: UIEdgeInsets { get set }

    var vmList: [PuzzleCellModelProtocol] { get set }

    var extra: PuzzleDisplayComponentExtra { get }

    var itemCount: Int { get }

    func calContentSize(_ context: PuzzleContext)
}

public class PuzzleDisplayComponentExtra {
    var sectionIndex = 0

    var logicComponent: PuzzleBusinessComponent?

    public var startY: CGFloat = 0

    var frameInCollectionView = CGRect.zero

    var decorateViewFrameInCollectionView: CGRect?

    var decorateViewAttributes: PuzzleDecorationAttributes?
}

public class PuzzleDisplayComponentCellAttributes {
    let item: Int

    let frameInComponent: CGRect

    let viewClass: UICollectionViewCell.Type

    let viewModel: PuzzleCellModelProtocol

    weak var uiComponent: PuzzleDisplayComponent?

    var frameInCollectionView: CGRect = .zero

    var cAttributes: UICollectionViewLayoutAttributes?

    init(item: Int, frameInComponent: CGRect, viewClass: UICollectionViewCell.Type, viewModel: PuzzleCellModelProtocol) {
        self.frameInComponent = frameInComponent
        self.viewClass = viewClass
        self.viewModel = viewModel
        self.item = item
    }
}
