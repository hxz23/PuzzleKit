//
//  EntranceCell.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import URLNavigator

class EntranceCell: UICollectionViewCell, PuzzleCellProtocol {
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

    var viewModel: EntranceCellModel?
    func update(_ object: AnyObject) {
        guard let vm = object as? EntranceCellModel else { return }
        viewModel = vm

        titleLabel.text = vm.entrance.title
    }

    func didSelected() {
        guard let vm = viewModel else { return }

        switch vm.entrance {
        case .list:
            let vc = ListDemoViewController()
            Navigator().push(vc)
        case .grid:
            let vc = GridDemoViewController()
            Navigator().push(vc)
        case .wrap:
            let vc = WrapDemoViewController()
            Navigator().push(vc)
        case .refresh:
            let vc = RefreshDemoViewController()
            Navigator().push(vc)
        case .event:
            
            let vc = EventDemoViewController()
            Navigator().push(vc)
        }
    }
}

enum Entrance: String {
    case grid
    case list
    case wrap
    case refresh
    case event
    
    var title: String {
        switch self {
        case .grid:
            return "grid 组件"
        case .list:
            return "list 组件"
        case .wrap:
            return "wrap 组件"
        case .refresh:
            return "页面刷新展示"
        case .event:
            return "事件展示 eventBus"
        }
    }
}

class EntranceCellModel: PuzzleListCellModel {
    let entrance: Entrance

    init(entrance: Entrance) {
        self.entrance = entrance

        super.init()
        height = 50
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        EntranceCell.self
    }
}
