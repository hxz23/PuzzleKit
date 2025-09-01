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

        title = "Demo 展示"
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
            PuzzleListComponent(
                viewModels: [
                    EntranceCellModel(entrance: .list),
                    EntranceCellModel(entrance: .grid),
                    EntranceCellModel(entrance: .wrap),
                    EntranceCellModel(entrance: .refresh),
                    EntranceCellModel(entrance: .event)
                ]
            )
        ]
    }
}
