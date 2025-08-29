//
//  PuzzleGridComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/23.
//

import Foundation

public final class PuzzleGridComponent: PuzzleDisplayComponent {
    public weak var logicComponent: PuzzleBusinessComponent?

    public var contentPadding: UIEdgeInsets = .zero

    public var contentSize: CGSize = .zero

    public var attributesList: [PuzzleDisplayComponentCellAttributes] = []

    public var decorateViewModel: PuzzleDecorationViewModel?

    public var decorateViewPadding: UIEdgeInsets = .zero

    public var vmList: [PuzzleCellModelProtocol] = []

    public var extra = PuzzleDisplayComponentExtra()

    public var itemCount = 0

    public let numOfLine: Int

    public let itemHeight: CGFloat

    public let itemSpacing: CGFloat

    public let lineSpacing: CGFloat

    public let viewModels: [PuzzleGridCellModel]

    public init(
        viewModels: [PuzzleGridCellModel],
        numOfLine: Int,
        itemHeight: CGFloat,
        itemSpacing: CGFloat,
        lineSpacing: CGFloat,
        contentPadding: UIEdgeInsets = .zero,
        decorateViewModel: PuzzleDecorationViewModel? = nil,
        decorateViewMargin: UIEdgeInsets = .zero
    ) {
        self.viewModels = viewModels
        vmList = viewModels
        self.contentPadding = contentPadding
        self.decorateViewModel = decorateViewModel
        decorateViewPadding = decorateViewMargin
        itemCount = viewModels.count

        self.numOfLine = numOfLine
        self.itemHeight = itemHeight
        self.itemSpacing = itemSpacing
        self.lineSpacing = lineSpacing
    }

    public func calContentSize(_ context: PuzzleContext) {
        let width = context.width
        
        attributesList = []

        let beginY = contentPadding.top
        let beginX = contentPadding.left

        let itemWidth = (width - itemSpacing * CGFloat(numOfLine - 1) - contentPadding.left - contentPadding.right) / CGFloat(numOfLine)

        for (line, list) in viewModels.group(with: numOfLine).enumerated() {
            for (index, vm) in list.enumerated() {
                vm.size = .init(width: itemWidth, height: itemHeight)

                let item = line * numOfLine + index
                let frame = CGRect(
                    x: beginX + CGFloat(index) * (itemWidth + itemSpacing),
                    y: beginY + CGFloat(line) * (itemHeight + lineSpacing),
                    width: itemWidth,
                    height: itemHeight
                )

                let attributes = PuzzleDisplayComponentCellAttributes(item: item, frameInComponent: frame, viewClass: vm.createViewClass(), viewModel: vm)
                attributes.uiComponent = self
                attributesList.append(attributes)
            }
        }

        let lastItemMaxY = attributesList.last?.frameInComponent.maxY ?? 0
        contentSize = .init(width: width, height: lastItemMaxY + contentPadding.bottom)
    }
}
