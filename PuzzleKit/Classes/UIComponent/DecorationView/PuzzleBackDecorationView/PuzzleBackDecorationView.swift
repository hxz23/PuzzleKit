//
//  PuzzleBackDecorationView.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public class PuzzleBackDecorationView: PuzzleDecorationAbstractView {
    public var viewModel: PuzzleBackDecorationViewModel?

    override public func update(_ viewModel: PuzzleDecorationAbstractVM?) {
        self.viewModel = viewModel as? PuzzleBackDecorationViewModel
        addCorners()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        addCorners()
    }

    func addCorners() {
        guard let vm = viewModel else { return }
        backgroundColor = vm.backgroudColor
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
}

open class PuzzleBackDecorationViewModel: PuzzleDecorationAbstractVM {
    var backgroudColor = UIColor.red
    var cornerRadius: CGFloat = 0
    var corners: UIRectCorner = .allCorners
    var zPosition: CGFloat = 0

    public convenience init(color: UIColor, cornerRadius: CGFloat, zPosition: CGFloat = 0, corners: UIRectCorner = [.allCorners]) {
        self.init()
        backgroudColor = color
        self.cornerRadius = cornerRadius
        self.zPosition = zPosition
        self.corners = corners
    }

    override public func decorationViewClass() -> PuzzleDecorationAbstractView.Type {
        return PuzzleBackDecorationView.self
    }
}
