//
//  PuzzleBgDecorationView.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public class PuzzleBgDecorationView: PuzzleDecorationView {
    public var viewModel: PuzzleBgDecorationViewModel?

    override public func update(_ viewModel: PuzzleDecorationViewModel?) {
        self.viewModel = viewModel as? PuzzleBgDecorationViewModel
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
}

open class PuzzleBgDecorationViewModel: PuzzleDecorationViewModel {
    var bgColor = UIColor.red
    var cornerRadius: CGFloat = 0
    var corners: UIRectCorner = .allCorners
    var zPosition: CGFloat = 0

    public convenience init(color: UIColor, cornerRadius: CGFloat, zPosition: CGFloat = 0, corners: UIRectCorner = [.allCorners]) {
        self.init()
        bgColor = color
        self.cornerRadius = cornerRadius
        self.zPosition = zPosition
        self.corners = corners
    }

    override public func decorationViewClass() -> PuzzleDecorationView.Type {
        return PuzzleBgDecorationView.self
    }
}
