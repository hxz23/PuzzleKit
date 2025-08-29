//
//  PuzzleListComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

public enum PuzzleSpace {
    case none
    case fixed(value: CGFloat)
    case dynamicVM(_ block: (_ top: AnyObject, _ bottom: AnyObject) -> CGFloat)
    case dynamicIndex(_ block: (_ index: Int) -> CGFloat)
}

public final class PuzzleListComponent: PuzzleDisplayComponent {
    public weak var logicComponent: PuzzleBusinessComponent?

    public var vmList: [PuzzleCellModelProtocol] = []

    public let extra = PuzzleDisplayComponentExtra()

    public var contentPadding: UIEdgeInsets = .zero

    public var contentSize: CGSize = .zero

    public var attributesList: [PuzzleDisplayComponentCellAttributes] = []

    public var decorateViewModel: PuzzleDecorationViewModel?

    public var decorateViewPadding: UIEdgeInsets = .zero

    public var itemCount: Int {
        viewModels.count
    }

    private var space = PuzzleSpace.none

    private var viewModels = [PuzzleListCellModel]()

    public init(
        viewModels: [PuzzleListCellModel],
        space: PuzzleSpace = .none,
        contentPadding: UIEdgeInsets = .zero,
        decorateViewModel: PuzzleDecorationViewModel? = nil,
        decorateViewMargin: UIEdgeInsets = .zero
    ) {
        self.viewModels = viewModels
        vmList = viewModels
        self.space = space
        self.contentPadding = contentPadding
        self.decorateViewModel = decorateViewModel
        decorateViewPadding = decorateViewMargin
    }

    public func calContentSize(_ context: PuzzleContext) {
        let width = context.width
        var beginY = contentPadding.top

        for (index, vm) in viewModels.enumerated() {
            let itemWidth = width - contentPadding.left - contentPadding.right
            let itemHeight = vm.height

            let attributes = PuzzleDisplayComponentCellAttributes(
                item: index,
                frameInComponent: .init(x: contentPadding.left, y: beginY, width: itemWidth, height: itemHeight),
                viewClass: vm.createViewClass(),
                viewModel: vm
            )
            attributes.uiComponent = self

            attributesList.append(attributes)

            beginY += itemHeight

            if index < viewModels.count - 1 {
                switch space {
                case .none:
                    break
                case let .fixed(value: value):
                    beginY += value
                case let .dynamicVM(block):
                    if index + 1 < viewModels.count {
                        let next = viewModels[index + 1]
                        beginY += block(vm, next)
                    }
                case let .dynamicIndex(block):
                    beginY += block(index)
                }
            }
        }

        contentSize = .init(width: width, height: beginY + contentPadding.bottom)
    }
}

public extension PuzzleListComponent {
    static func withTopMargin(_ value: CGFloat) -> PuzzleListComponent {
        return PuzzleListComponent(
            viewModels: [],
            space: .none,
            contentPadding: .init(top: value, left: 0, bottom: 0, right: 0),
            decorateViewModel: nil,
            decorateViewMargin: .zero
        )
    }
}
