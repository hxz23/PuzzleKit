//
//  GridColorCell.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class GridColorCell: UICollectionViewCell, PuzzleCellProtocol {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    var viewModel: GridColorCellModel?
    func update(_ object: AnyObject) { // 需要实现 PuzzleCellProtocol
        guard let vm = object as? GridColorCellModel else { return }
        viewModel = vm

        backgroundColor = vm.color
        titleLabel.text = "\(vm.index)"
    }
}

class GridColorCellModel: PuzzleGridCellModel {
    let index: Int
    let color: UIColor
    
    init(index: Int, color: UIColor) {
        self.color = color
        self.index = index

        super.init()
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        GridColorCell.self
    }
}
