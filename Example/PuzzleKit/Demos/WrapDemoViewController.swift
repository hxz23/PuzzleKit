//
//  WrapDemoViewController.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class WrapDemoViewController: PuzzleBaseViewController {
    let component = WrapDemoComponent()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "wrap component 演示"
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

class WrapDemoComponent: PuzzleBusinessComponent {
    override func setup() {
        super.setup()
        dataSource = self
    }

    func listComponent1() -> [PuzzleDisplayComponent] {
        let colors = ColorUtility.randomRGBColors(count: 9)
        let viewModels = colors.enumerated().map {
            let vm = WrapColorCellModel(index: $0.offset, color: $0.element)
            vm.width = 30 * CGFloat($0.offset) + 50
            return vm
        }
        return [
            PuzzleListComponent(
                viewModels: [SectionTitleCellModel(title: "warp 每个递增 30 宽度，放不下自动折行，row 间距 10，col 间距 10")]
            ),
            PuzzleWrapComponent(
                viewModels: viewModels,
                rowHeight: 50,
                rowSpacing: 10,
                colSpacing: 10
            )
        ]
    }
}

extension WrapDemoComponent: PuzzleBusinessComponentDatasource {
    func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleDisplayComponent] {
        var result = [PuzzleDisplayComponent]()
        result += listComponent1()

        return result
    }
}
