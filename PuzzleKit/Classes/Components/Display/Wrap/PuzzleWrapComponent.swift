//
//  PuzzleWrapComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public final class PuzzleWrapComponent: PuzzleDisplayComponent {
    public weak var logicComponent: PuzzleBusinessComponent?

    public var contentPadding: UIEdgeInsets = .zero

    public var contentSize: CGSize = .zero

    public var attributesList: [PuzzleDisplayComponentCellAttributes] = []

    public var decorateViewModel: PuzzleDecorationViewModel?

    public var decorateViewPadding: UIEdgeInsets = .zero

    public var vmList: [PuzzleCellModelProtocol] = []

    public var extra = PuzzleDisplayComponentExtra()

    public var itemCount = 0

    public let rowHeight: CGFloat

    public let rowSpacing: CGFloat

    public let colSpacing: CGFloat

    public let viewModels: [PuzzleWrapCellModel]

    public let maxLines: Int?

    public init(
        viewModels: [PuzzleWrapCellModel],
        rowHeight: CGFloat,
        rowSpacing: CGFloat,
        colSpacing: CGFloat,
        contentPadding: UIEdgeInsets = .zero,
        decorateViewModel: PuzzleDecorationViewModel? = nil,
        decorateViewMargin: UIEdgeInsets = .zero,
        maxLines: Int? = nil
    ) {
        self.viewModels = viewModels
        vmList = viewModels
        self.contentPadding = contentPadding
        self.decorateViewModel = decorateViewModel
        decorateViewPadding = decorateViewMargin
        itemCount = viewModels.count

        self.rowHeight = rowHeight
        self.rowSpacing = rowSpacing
        self.colSpacing = colSpacing
        self.maxLines = maxLines
    }

    public func calContentSize(_ context: PuzzleContext) {
        let width = context.width
        
        attributesList = []

        var beginY = contentPadding.top
        var beginX = contentPadding.left
        var countOfLine = 0

        let maxItemWidth = width - contentPadding.left - contentPadding.right

        // 每行有item的时候，下一个item放不下，换行
        // 如果一行的最大距离，展示不下一个item，item 宽度展示为 maxItemWidth
        var lineNum = 0

        for (item, vm) in viewModels.enumerated() {
            let frameInComponent: CGRect
//            print(#function, item, vm.width, maxItemWidth, beginX, maxItemWidth - beginX)

            let reminder = maxItemWidth - beginX + contentPadding.left
            if vm.width <= reminder { // 不换行
                vm.displayWidth = vm.width

                frameInComponent = CGRect(x: beginX, y: beginY, width: vm.displayWidth, height: rowHeight)
                beginX = frameInComponent.maxX + rowSpacing

                countOfLine += 1
            } else if countOfLine == 0 { // 不换行
                vm.displayWidth = maxItemWidth
                frameInComponent = CGRect(x: beginX, y: beginY, width: vm.displayWidth, height: rowHeight)

                beginX = frameInComponent.maxX + rowSpacing

                countOfLine += 1
            } else { // 换行
                countOfLine = 0

                lineNum += 1

                if let max = maxLines, lineNum == max {
                    break
                }

                beginY += rowHeight + colSpacing
                beginX = contentPadding.left

                if vm.width > maxItemWidth {
                    vm.displayWidth = maxItemWidth
                } else {
                    vm.displayWidth = vm.width
                }

                frameInComponent = CGRect(x: beginX, y: beginY, width: vm.displayWidth, height: rowHeight)

                beginX = frameInComponent.maxX + rowSpacing
                countOfLine += 1
            }

            let attributes = PuzzleDisplayComponentCellAttributes(
                item: item,
                frameInComponent: frameInComponent,
                viewClass: vm.createViewClass(),
                viewModel: vm
            )
            attributes.uiComponent = self
            attributesList.append(attributes)
        }

        let lastItemMaxY = attributesList.last?.frameInComponent.maxY ?? 0
        contentSize = .init(width: width, height: lastItemMaxY + contentPadding.bottom)
    }
}
