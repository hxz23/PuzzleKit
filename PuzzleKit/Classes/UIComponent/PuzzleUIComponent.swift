//
//  PuzzleUIComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

public protocol PuzzleAbstractUIComponent: AnyObject {
    // weak
    var logicComponent: PuzzleLogicComponent? { get set }

    var contentPadding: UIEdgeInsets { get set }

    var contentSize: CGSize { get set }

    var attributesList: [PuzzleItemViewAttributes] { get set }

    var decorateViewModel: PuzzleDecorationAbstractVM? { get set }

    var decorateViewPadding: UIEdgeInsets { get set }

    var vmList: [PuzzleViewModelSizeProtocol] { get set }

    var extra: PuzzleAbstractUIComponentExtra { get }

    var itemCount: Int { get }

    func update(_ width: CGFloat)
}

public class PuzzleAbstractUIComponentExtra {
    var sectionIndex = 0

    var logicComponent: PuzzleLogicComponent?

    public var startY: CGFloat = 0

    var frameInCollectionView = CGRect.zero

    var decorateViewFrameInCollectionView: CGRect?

    var decorateViewAttributes: PuzzleDecorationAttributes?
}

public class PuzzleItemViewAttributes {
    let item: Int

    let frameInComponent: CGRect

    let viewClass: UICollectionViewCell.Type

    let viewModel: PuzzleViewModelSizeProtocol

    weak var uiComponent: PuzzleAbstractUIComponent?

    var frameInCollectionView: CGRect = .zero

    var cAttributes: UICollectionViewLayoutAttributes?

    init(item: Int, frameInComponent: CGRect, viewClass: UICollectionViewCell.Type, viewModel: PuzzleViewModelSizeProtocol) {
        self.frameInComponent = frameInComponent
        self.viewClass = viewClass
        self.viewModel = viewModel
        self.item = item
    }
}
