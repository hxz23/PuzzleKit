//
//  ListColorCell.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class ListColorCell: UICollectionViewCell, PuzzleCellProtocol {
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

    var viewModel: ListColorCellModel?
    func update(_ object: AnyObject) { // 需要实现 PuzzleCellProtocol
        guard let vm = object as? ListColorCellModel else { return }
        viewModel = vm

        backgroundColor = vm.color
        titleLabel.text = "\(vm.index)"
    }
}

class ListColorCellModel: PuzzleListCellModel {
    var index: Int
    let color: UIColor
    
    init(index: Int, color: UIColor, height: CGFloat) {
        self.color = color
        self.index = index

        super.init()
        self.height = height
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        ListColorCell.self
    }
}
