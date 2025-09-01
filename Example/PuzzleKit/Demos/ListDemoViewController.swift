//
//  ListDemoViewController.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class ListDemoViewController: PuzzleBaseViewController {
    let component = ListDemoComponent()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "list component 演示"
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

class ListDemoComponent: PuzzleBusinessComponent {
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
        let colors = ColorUtility.randomRGBColors(count: 5)
        let viewModels = colors.enumerated().map {
            ListColorCellModel(index: $0.offset, color: $0.element, height: 50)
        }
        return [
            PuzzleListComponent(
                viewModels: [SectionTitleCellModel(title: "list 样式 + 间距 10")]
            ),
            PuzzleListComponent(
                viewModels: viewModels,
                space: .fixed(value: 10)
            )
        ]
    }
    
    func listComponent3() -> [PuzzleDisplayComponent] {
        let colors = ColorUtility.randomRGBColors(count: 5)
        let viewModels = colors.enumerated().map {
            ListColorCellModel(index: $0.offset, color: $0.element, height: 50)
        }

        return [
            PuzzleListComponent(
                viewModels: [SectionTitleCellModel(title: "list 样式 + spacing + contentPadding")]
            ),
            PuzzleListComponent(
                viewModels: viewModels,
                space: .fixed(value: 10),
                contentPadding: .init(top: 30, left: 30, bottom: 30, right: 30)
            )
        ]
    }
    
    func listComponent4() -> [PuzzleDisplayComponent] {
        let colors = ColorUtility.randomRGBColors(count: 5)
        let viewModels = colors.enumerated().map {
            ListColorCellModel(index: $0.offset, color: $0.element, height: 50)
        }

        return [
            PuzzleListComponent(
                viewModels: [SectionTitleCellModel(title: "list 样式  + spacing + contentPadding + decorate ")]
            ),
            PuzzleListComponent(
                viewModels: viewModels,
                space: .fixed(value: 10),
                contentPadding: .init(top: 30, left: 30, bottom: 30, right: 30),
                decorateViewModel: .init(color: .lightGray, cornerRadius: 8)
            )
        ]
    }
}

extension ListDemoComponent: PuzzleBusinessComponentDatasource {
    func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleDisplayComponent] {
        var result = [PuzzleDisplayComponent]()
        result += listComponent1()
        result += listComponent2()
        result += listComponent3()
        result += listComponent4()

        return result
    }
}
