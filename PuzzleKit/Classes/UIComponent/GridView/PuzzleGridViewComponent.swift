//
//  PuzzleGridViewComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/23.
//

import Foundation

public final class PuzzleGridViewComponent: PuzzleAbstractUIComponent {
    public weak var logicComponent: PuzzleLogicComponent?

    public var contentPadding: UIEdgeInsets = .zero

    public var contentSize: CGSize = .zero

    public var attributesList: [PuzzleItemViewAttributes] = []

    public var decorateViewModel: PuzzleDecorationAbstractVM?

    public var decorateViewPadding: UIEdgeInsets = .zero

    public var vmList: [PuzzleViewModelSizeProtocol] = []

    public var extra = PuzzleAbstractUIComponentExtra()

    public var itemCount: Int = 0

    public let numOfLine: Int

    public let itemHeight: CGFloat

    public let itemSpacing: CGFloat

    public let lineSpacing: CGFloat

    public let viewModels: [PuzzleGridViewAbstractionVM]

    public init(viewModels: [PuzzleGridViewAbstractionVM], numOfLine: Int, itemHeight: CGFloat, itemSpacing: CGFloat, lineSpacing: CGFloat, contentPadding: UIEdgeInsets = .zero, decorateViewModel: PuzzleDecorationAbstractVM? = nil, decorateViewMargin: UIEdgeInsets = .zero) {
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

    public func update(_ width: CGFloat) {
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

                let attributes = PuzzleItemViewAttributes(item: item, frameInComponent: frame, viewClass: vm.createViewClass(), viewModel: vm)
                attributes.uiComponent = self
                attributesList.append(attributes)
            }
        }

        let lastItemMaxY = attributesList.last?.frameInComponent.maxY ?? 0
        contentSize = .init(width: width, height: lastItemMaxY + contentPadding.bottom)
    }
}

public extension Array {
    func group(with count: Int) -> [[Element]] {
        var result = [[Element]]()

        var sub = [Element]()
        var index = 0
        for (_, item) in enumerated() {
            index += 1
            sub.append(item)

            if index == count {
                result.append(sub)
                sub = []
                index = 0
            }
        }

        if sub.isEmpty == false {
            result.append(sub)
        }

        return result
    }
}
