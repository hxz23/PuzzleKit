//
//  PuzzleListViewSepVM.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2022/8/31.
//

import Foundation
import UIKit

class PuzzleListSepView: UICollectionViewCell, PuzzleItemViewProtocol {
    let v = UIView()

    func update(_ object: AnyObject) {
        guard let vm = object as? PuzzleListSepVM else { return }
        if v.superview == nil {
            contentView.addSubview(v)
        }

        v.snp.remakeConstraints { make in
            make.left.equalTo(vm.margin.left)
            make.top.equalTo(vm.margin.top)
            make.right.equalTo(-vm.margin.right)
            make.bottom.equalTo(-vm.margin.bottom)
        }
        v.backgroundColor = vm.backgroundColor
    }
}

open class PuzzleListSepVM: PuzzleListViewAbstractionVM {
    public convenience init(color: UIColor, margin: UIEdgeInsets, height: CGFloat) {
        self.init()
        backgroundColor = color
        self.margin = margin
        self.height = height
    }

    public var backgroundColor = UIColor.clear
    public var margin = UIEdgeInsets.zero

    override open func createViewClass() -> UICollectionViewCell.Type {
        PuzzleListSepView.self
    }
}
