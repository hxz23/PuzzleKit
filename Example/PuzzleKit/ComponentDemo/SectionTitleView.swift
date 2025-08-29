//
//  SectionTitleView.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/7/24.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class SectionTitleView: UICollectionViewCell, PuzzleCellProtocol {
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
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
    }

    func update(_ object: AnyObject) {
        guard let vm = object as? SectionTitleViewModel else { return }

        titleLabel.text = vm.title
    }
}

class SectionTitleViewModel: PuzzleListCellModel {
    let title: String

    init(title: String) {
        self.title = title

        super.init()
        height = 50
//        super.init(height: 50)
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        SectionTitleView.self
    }
}
