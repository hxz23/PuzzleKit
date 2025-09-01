//
//  EventCell.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

protocol DemoEvent {
    func demoEventTapAction()
}

class SendEventCell: UICollectionViewCell, PuzzleCellProtocol {
    let titleLabel = UILabel()
    
    let button = UIButton()

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
            make.top.equalTo(12)
        }
        
        titleLabel.text = "发送事件 cell"
        
        button.setTitle("点击", for: .normal)
        button.backgroundColor = .red
        
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    
    @objc func buttonClick() {
        guard let vm = viewModel else { return }
        
        vm.eventBus?.broadcaster.notify(DemoEvent.self) {
            $0.demoEventTapAction()
        }
    }

    var viewModel: SendEventCellModel?
    func update(_ object: AnyObject) { // 需要实现 PuzzleCellProtocol
        guard let vm = object as? SendEventCellModel else { return }
        viewModel = vm
    }
}

class SendEventCellModel: PuzzleListCellModel {
    override init() {
        super.init()
        
        height = 100
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        SendEventCell.self
    }
}

class ReceiveEventCell: UICollectionViewCell, PuzzleCellProtocol, DemoEvent {
    let titleLabel = UILabel()
    let label2 = UILabel()

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
            make.top.equalTo(12)
        }
        
        contentView.addSubview(label2)

        label2.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.text = "接收事件 cell"
    }

    var viewModel: ReceiveEventCellModel?
    func update(_ object: AnyObject) { // 需要实现 PuzzleCellProtocol
        guard let vm = object as? ReceiveEventCellModel else { return }
        viewModel = vm

        vm.eventBus?.broadcaster.register(DemoEvent.self, observer: self)
        updateCountLabel()
    }
    
    func demoEventTapAction() {
        guard let vm = viewModel else { return }
        vm.count += 1
        
        updateCountLabel()
    }
    
    func updateCountLabel() {
        guard let vm = viewModel else { return }

        label2.text = "点击次数: \(vm.count)"
    }
}

class ReceiveEventCellModel: PuzzleListCellModel {
    var count = 0
    
    override init() {
        super.init()
        
        height = 100
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        ReceiveEventCell.self
    }
}
