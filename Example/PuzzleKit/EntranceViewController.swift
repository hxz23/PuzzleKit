//
//  EntranceViewController.swift
//  PuzzleKit
//
//  Created by haoxuezhi on 01/05/2024.
//  Copyright (c) 2024 haoxuezhi. All rights reserved.
//

import UIKit

class EntranceViewController: PuzzleBaseViewController {
    let component = EntranceMainComponents()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "入口"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func logicComponents() -> [PuzzleBusinessComponent] {
        [
            component
        ]
    }
}

class EntranceMainComponents: PuzzleBusinessComponent {
    override func setup() {
        super.setup()
        dataSource = self
    }
}

extension EntranceMainComponents: PuzzleBusinessComponentDatasource {
    func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleDisplayComponent] {
        return [
            PuzzleListDisplayComponent(viewModels: [
                EntranceViewModel(entrance: .uiComponentDemo)
//                EntranceViewModel(entrance: .grid),
            ])
        ]
    }
}

class EntranceView: UICollectionViewCell, PuzzleCellProtocol {
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

    var viewModel: EntranceViewModel?
    func update(_ object: AnyObject) {
        guard let vm = object as? EntranceViewModel else { return }
        viewModel = vm

        titleLabel.text = vm.entrance.rawValue
    }

    func didSelected() {
        guard let vm = viewModel else { return }

//        switch vm.entrance {
//        case .uiComponentDemo:
//            let vc = ComponentDemoViewController()
//
//        case .list:
//        }
    }
}

enum Entrance: String {
    case uiComponentDemo
    case list
}

class EntranceViewModel: PuzzleListCellModel {
    let entrance: Entrance

    init(entrance: Entrance) {
        self.entrance = entrance

        super.init()
        height = 50
//        super.init(height: 50)
    }

    override func createViewClass() -> UICollectionViewCell.Type {
        EntranceView.self
    }
}
