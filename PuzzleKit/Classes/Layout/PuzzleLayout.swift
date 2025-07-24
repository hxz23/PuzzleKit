//
//  PuzzleLayout.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

public class PuzzleLayout: UICollectionViewLayout {
    private(set) var uiComponents = [PuzzleAbstractUIComponent]()

    public var floatOffset: CGFloat = 0
    public var collectionViewMinHeight: CGFloat?

    var collectionViewWidth: CGFloat = 0
//    1）-(void)prepareLayout  设置layout的结构和初始需要的参数等。
//
//    2)  -(CGSize) collectionViewContentSize 确定collectionView的所有内容的尺寸。
//
//    3）-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。
//
//    4)在需要更新layout时，需要给当前layout发送
//         1)-invalidateLayout， 该消息会立即返回，并且预约在下一个loop的时候刷新当前layout
//         2)-prepareLayout，
//         3)依次再调用-collectionViewContentSize和-layoutAttributesForElementsInRect来生成更新后的布局。
    private var maxHeight: CGFloat = 0

    private var decorationViewElementKindList = [String]()

    private var showAttributesMap = [CGRect: [UICollectionViewLayoutAttributes]]()

    // 浮动视图
    private var floatAttributesList = [PuzzleItemViewAttributes]()

    override public func prepare() {
        super.prepare()
    }

    func updateUIComponents(_ list: [PuzzleAbstractUIComponent]) {
        uiComponents = list
        showAttributesMap = [:]
        floatAttributesList = []

        var startComponentY: CGFloat = 0

        for (section, uiCp) in uiComponents.enumerated() {
            uiCp.update(collectionViewWidth)
            let uiCpFrame = CGRect(x: 0, y: startComponentY, width: collectionViewWidth, height: uiCp.contentSize.height)
            uiCp.extra.frameInCollectionView = uiCpFrame
            uiCp.extra.startY = uiCpFrame.minY
            for (item, attribute) in uiCp.attributesList.enumerated() {
                let frameInCollectionView = attribute.frameInComponent.offsetBy(dx: 0, dy: startComponentY)
                attribute.frameInCollectionView = frameInCollectionView
                uiCp.vmList[item].frameInCollection = frameInCollectionView

                let cAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: item, section: section))
                cAttributes.frame = frameInCollectionView
                cAttributes.zIndex = 200
                attribute.cAttributes = cAttributes

                if attribute.viewModel.isFloat() {
                    floatAttributesList.append(attribute)
                }
            }

            startComponentY += uiCp.contentSize.height

            if let decorateViewModel = uiCp.decorateViewModel {
                if !decorationViewElementKindList.contains(decorateViewModel.decorationViewClass().description()) {
                    decorationViewElementKindList.append(decorateViewModel.decorationViewClass().description())
                    register(decorateViewModel.decorationViewClass(), forDecorationViewOfKind: decorateViewModel.decorationViewClass().description())
                }

                let decorateFrame = UIEdgeInsetsInsetRect(uiCpFrame, uiCp.decorateViewMargin) // uiCpFrame.inset(by: uiCp.decorateViewMargin)

                uiCp.extra.decorateViewFrameInCollectionView = decorateFrame
                let decAttributes = PuzzleDecorationAttributes(forDecorationViewOfKind: decorateViewModel.decorationViewClass().description(), with: .init(item: 0, section: section))
                decAttributes.zIndex = 100
                decAttributes.frame = decorateFrame
                decAttributes.vm = decorateViewModel

                uiCp.extra.decorateViewAttributes = decAttributes
            }
        }

        maxHeight = startComponentY
    }

    override public var collectionViewContentSize: CGSize {
        var height = maxHeight
        if let minHeight = collectionViewMinHeight {
            height = max(height, minHeight)
        }
        return .init(width: collectionViewWidth, height: height)
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        if let cachelist = self.showAttribuetsMap[rect] {
//            return cachelist
//        }
        var list = [UICollectionViewLayoutAttributes]()

        for uiCp in uiComponents {
            if uiCp.extra.frameInCollectionView.intersects(rect) {
                for attribute in uiCp.attributesList {
                    if attribute.frameInCollectionView.intersects(rect), let a = attribute.cAttributes {
                        if lastBounds != .zero, !attribute.viewModel.isFloat() {
                            list.append(a)
                        } else {
                            list.append(a)
                        }
                    }
                }

                if let decAttributes = uiCp.extra.decorateViewAttributes, decAttributes.frame.intersects(rect) {
                    list.append(decAttributes)
                }
            }
        }

        let floatRect = UIEdgeInsetsInsetRect(lastBounds, .init(top: floatOffset, left: 0, bottom: 0, right: 0))
        let floatAttributesList = floatAttributes(in: floatRect, list: floatAttributesList, isTop: true, isBottom: true)

        list.append(contentsOf: floatAttributesList)
        return list
    }

    func floatAttributes(in rect: CGRect, list: [PuzzleItemViewAttributes], isTop: Bool, isBottom: Bool) -> [UICollectionViewLayoutAttributes] {
        guard list.isEmpty == false, rect.height > 0 else { return [] }

        var result = [UICollectionViewLayoutAttributes]()

        let floatList = list.filter {
            $0.frameInCollectionView.minY <= rect.maxY
        }

        if let maxPriority = floatList.map({ $0.viewModel.floatPriority() }).max() {
            // 每次选取视图中 倒序优先级最高的视图，它的位置是固定的，剩余的top bottom重复这个过程
            var reverseMaxPriorityVM: PuzzleItemViewAttributes?
            var index: Int?

            for (i, vm) in floatList.enumerated().reversed() {
                if vm.viewModel.floatPriority() == maxPriority {
                    reverseMaxPriorityVM = floatList[i]
                    index = i
                    break
                }
            }

            guard let reverseMaxPriorityVM = reverseMaxPriorityVM, let index = index else {
                return []
            }
            guard let currentAttribute = reverseMaxPriorityVM.cAttributes?.copy() as? UICollectionViewLayoutAttributes else {
                return []
            }

            currentAttribute.zIndex = 300_000 + reverseMaxPriorityVM.viewModel.floatPriority()

            if currentAttribute.frame.minY <= rect.minY {
                currentAttribute.frame = CGRect(
                    x: currentAttribute.frame.minX,
                    y: rect.minY,
                    width: currentAttribute.frame.width,
                    height: currentAttribute.frame.height
                )

                if isBottom {
                } else if rect.maxY <= currentAttribute.frame.maxY {
                    currentAttribute.frame = CGRect(
                        x: currentAttribute.frame.minX,
                        y: rect.maxY - currentAttribute.frame.height,
                        width: currentAttribute.frame.width,
                        height: currentAttribute.frame.height
                    )
                }
                result.append(currentAttribute)
            } else {
                result.append(currentAttribute)
            }

            // 上面区域
            let topFrame = CGRect(
                x: rect.minX,
                y: rect.minY,
                width: rect.width,
                height: currentAttribute.frame.minY - rect.minY
            )
            var array = [PuzzleItemViewAttributes]()
            for (i, vm) in floatList.enumerated() {
                if i < index {
                    array.append(vm)
                }
            }

            result.append(contentsOf: floatAttributes(in: topFrame,
                                                      list: array,
                                                      isTop: isTop ? true : false,
                                                      isBottom: false))

            // 下面区域
            if currentAttribute.frame.maxY < rect.maxY {
                let bottomFrame = CGRect(
                    x: rect.minX,
                    y: currentAttribute.frame.maxY,
                    width: rect.width,
                    height: rect.maxY - currentAttribute.frame.maxY
                )

                var array = [PuzzleItemViewAttributes]()
                for (i, vm) in floatList.enumerated() {
                    if i > index {
                        array.append(vm)
                    }
                }

                result.append(contentsOf: floatAttributes(in: bottomFrame,
                                                          list: array,
                                                          isTop: isTop ? true : false,
                                                          isBottom: isBottom ? true : false))
            }
        }

        return result
    }

    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard uiComponents.count > indexPath.section else {
            return nil
        }
        let uiCp = uiComponents[indexPath.section]

        if uiCp.attributesList.count > indexPath.item {
            return uiCp.attributesList[indexPath.item].cAttributes
        }
        return nil
    }

    override public func layoutAttributesForDecorationView(ofKind _: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.item == 0 {
            return uiComponents[indexPath.section].extra.decorateViewAttributes
        }
        return nil
    }

    var lastBounds = CGRect.zero
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        lastBounds = newBounds
        return floatAttributesList.isEmpty == false
    }
}

extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(debugDescription)
    }
}
