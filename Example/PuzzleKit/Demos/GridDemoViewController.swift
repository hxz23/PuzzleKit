//
//  GridDemoViewController.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class GridDemoViewController: PuzzleBaseViewController {
    let component = GridDemoComponent()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "grid component 演示"
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

class GridDemoComponent: PuzzleBusinessComponent {
    override func setup() {
        super.setup()
        dataSource = self
    }

    func listComponent1() -> [PuzzleDisplayComponent] {
        let colors = ColorUtility.randomRGBColors(count: 5)
        let viewModels = colors.enumerated().map {
            ListColorCellModel(index: $0.offset, color: $0.element, height: 50)
        }
        return [
            PuzzleListComponent(
                viewModels: [SectionTitleCellModel(title: "list 样式")]
            ),
            PuzzleListComponent(
                viewModels: viewModels
            )
        ]
    }
    
    func listComponent2() -> [PuzzleDisplayComponent] {
        let colors = ColorUtility.randomRGBColors(count: 9)
        let viewModels = colors.enumerated().map {
            GridColorCellModel(index: $0.offset, color: $0.element)
        }
        return [
            PuzzleListComponent(
                viewModels: [SectionTitleCellModel(title: "grid 每行 3 个，row 间距 10，col 间距 10")]
            ),
            PuzzleGridComponent(
                viewModels: viewModels,
                numOfLine: 3,
                rowHeight: 50,
                rowSpacing: 10,
                colSpacing: 10,
                contentPadding: .init(top: 30, left: 30, bottom: 30, right: 30),
                decorateViewModel: .init(color: .lightGray, cornerRadius: 8),
                decorateViewMargin: .init(top: 10, left: 10, bottom: 10, right: 10)
            )
        ]
    }
}

extension GridDemoComponent: PuzzleBusinessComponentDatasource {
    func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleDisplayComponent] {
        var result = [PuzzleDisplayComponent]()
        result += listComponent1()
        result += listComponent2()

        return result
    }
}
