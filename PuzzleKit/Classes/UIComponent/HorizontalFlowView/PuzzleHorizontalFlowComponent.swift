//
//  PuzzleHorizontalFlowComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public final class PuzzleHorizontalFlowComponent: PuzzleAbstractUIComponent {
    public weak var logicComponent: PuzzleLogicComponent?

    public var contentPadding: UIEdgeInsets = .zero

    public var contentSize: CGSize = .zero

    public var attributesList: [PuzzleItemViewAttributes] = []

    public var decorateViewModel: PuzzleDecorationAbstractVM?

    public var decorateViewPadding: UIEdgeInsets = .zero

    public var vmList: [PuzzleViewModelSizeProtocol] = []

    public var extra = PuzzleAbstractUIComponentExtra()

    public var itemCount: Int = 0

    public let itemHeight: CGFloat

    public let itemSpacing: CGFloat

    public let lineSpacing: CGFloat

    public let viewModels: [PuzzleHorizontalFlowAbstractionVM]

    public let maxLines: Int?

    public init(viewModels: [PuzzleHorizontalFlowAbstractionVM], itemHeight: CGFloat, itemSpacing: CGFloat, lineSpacing: CGFloat, contentPadding: UIEdgeInsets = .zero, decorateViewModel: PuzzleDecorationAbstractVM? = nil, decorateViewMargin: UIEdgeInsets = .zero, maxLines: Int? = nil) {
        self.viewModels = viewModels
        vmList = viewModels
        self.contentPadding = contentPadding
        self.decorateViewModel = decorateViewModel
        decorateViewPadding = decorateViewMargin
        itemCount = viewModels.count

        self.itemHeight = itemHeight
        self.itemSpacing = itemSpacing
        self.lineSpacing = lineSpacing
        self.maxLines = maxLines
    }

    public func update(_ width: CGFloat) {
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

                frameInComponent = CGRect(x: beginX, y: beginY, width: vm.displayWidth, height: itemHeight)
                beginX = frameInComponent.maxX + itemSpacing

                countOfLine += 1
            } else if countOfLine == 0 { // 不换行
                vm.displayWidth = maxItemWidth
                frameInComponent = CGRect(x: beginX, y: beginY, width: vm.displayWidth, height: itemHeight)

                beginX = frameInComponent.maxX + itemSpacing

                countOfLine += 1
            } else { // 换行
                countOfLine = 0

                lineNum += 1

                if let max = maxLines, lineNum == max {
                    break
                }

                beginY += itemHeight + lineSpacing
                beginX = contentPadding.left

                if vm.width > maxItemWidth {
                    vm.displayWidth = maxItemWidth
                } else {
                    vm.displayWidth = vm.width
                }

                frameInComponent = CGRect(x: beginX, y: beginY, width: vm.displayWidth, height: itemHeight)

                beginX = frameInComponent.maxX + itemSpacing
                countOfLine += 1
            }

            let attributes = PuzzleItemViewAttributes(
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
