//
//  PuzzleDecorationView.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/23.
//

import Foundation

class PuzzleDecorationAttributes: UICollectionViewLayoutAttributes {
    var viewModel: PuzzleDecorationViewModel?
}

open class PuzzleDecorationView: UICollectionReusableView {
    public var viewModel: PuzzleDecorationViewModel?

    public func update(_ viewModel: PuzzleDecorationViewModel?) {
        self.viewModel = viewModel
        addCorners()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        addCorners()
    }

    func addCorners() {
        guard let vm = viewModel else { return }
        backgroundColor = vm.bgColor
        layer.zPosition = vm.zPosition
        roundCorners(vm.corners, radius: vm.cornerRadius)
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    override open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attributes = layoutAttributes as? PuzzleDecorationAttributes {
            update(attributes.viewModel)
        }
    }
}

open class PuzzleDecorationViewModel {
    var bgColor = UIColor.red
    var cornerRadius: CGFloat = 0
    var corners: UIRectCorner = .allCorners
    var zPosition: CGFloat = 0

    public convenience init(
        color: UIColor,
        cornerRadius: CGFloat,
        corners: UIRectCorner = [.allCorners],
        zPosition: CGFloat = 0
    ) {
        self.init()
        bgColor = color
        self.cornerRadius = cornerRadius
        self.zPosition = zPosition
        self.corners = corners
    }
    
    public init() { }
    
    open func decorationViewClass() -> PuzzleDecorationView.Type {
        return PuzzleDecorationView.self
    }
}
