//
//  LoadingCell.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class LoadingCell: UICollectionViewCell, PuzzleCellProtocol {
    let stackView = UIStackView()
    
    let titleLabel = UILabel()
    let indicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(indicatorView)
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .vertical
    }

    var viewModel: LoadingCellModel?
    func update(_ object: AnyObject) { // 需要实现 PuzzleCellProtocol
        guard let vm = object as? LoadingCellModel else { return }
        viewModel = vm

        indicatorView.isHidden = vm.status != .loading
        if vm.status == .loading {
            indicatorView.startAnimating()
        }
        
        titleLabel.text = "\(vm.status.msg)"
    }
}

enum LoadingStatus {
    case loading
    case error
    case success
    
    var msg: String {
        switch self {
        case .loading:
            return "加载中"
        case .error:
            return "Error"
        case .success:
            return "Success!!!"
        }
    }
}

class LoadingCellModel: PuzzleListCellModel {
    var status = LoadingStatus.success
    
    override init() {
        super.init()
        height = 100
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        LoadingCell.self
    }
}
