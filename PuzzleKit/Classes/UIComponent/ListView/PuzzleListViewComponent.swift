//
//  PuzzleListViewComponent.swift
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

public final class PuzzleListViewComponent: PuzzleAbstractUIComponent {
    public weak var logicComponent: PuzzleLogicComponent?

    public var vmList: [PuzzleViewModelSizeProtocol] = []

    public let extra = PuzzleAbstractUIComponentExtra()

    public var contentPadding: UIEdgeInsets = .zero

    public var contentSize: CGSize = .zero

    public var attributesList: [PuzzleItemViewAttributes] = []

    public var decorateViewModel: PuzzleDecorationAbstractVM?

    public var decorateViewPadding: UIEdgeInsets = .zero

    public var itemCount: Int {
        vms.count
    }

    private var space = PuzzleSpace.none

    private var vms = [PuzzleListViewAbstractionVM]()

    public init(vms: [PuzzleListViewAbstractionVM], space: PuzzleSpace = .none, contentPadding: UIEdgeInsets = .zero, decorateViewModel: PuzzleDecorationAbstractVM? = nil, decorateViewMargin: UIEdgeInsets = .zero) {
        self.vms = vms
        vmList = vms
        self.space = space
        self.contentPadding = contentPadding
        self.decorateViewModel = decorateViewModel
        decorateViewPadding = decorateViewMargin
    }

    public func update(_ width: CGFloat) {
        var beginY = contentPadding.top

        for (index, vm) in vms.enumerated() {
            let itemWidth = width - contentPadding.left - contentPadding.right
            let itemHeight = vm.height

            let attributes = PuzzleItemViewAttributes(item: index, frameInComponent: .init(x: contentPadding.left, y: beginY, width: itemWidth, height: itemHeight), viewClass: vm.createViewClass(), viewModel: vm)
            attributes.uiComponent = self

            attributesList.append(attributes)

            beginY += itemHeight

            if index < vms.count - 1 {
                switch space {
                case .none:
                    break
                case let .fixed(value: value):
                    beginY += value
                case let .dynamicVM(block):
                    if index + 1 < vms.count {
                        let next = vms[index + 1]
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

public extension PuzzleListViewComponent {
    static func margin(_ value: CGFloat) -> PuzzleListViewComponent {
        return PuzzleListViewComponent(
            vms: [],
            space: .none,
            contentPadding: .init(top: value, left: 0, bottom: 0, right: 0),
            decorateViewModel: nil,
            decorateViewMargin: .zero
        )
    }
}
