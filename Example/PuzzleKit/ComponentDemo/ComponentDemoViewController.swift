//
//  ComponentDemoViewController.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/7/24.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class ComponentDemoViewController: PuzzleBaseViewController {
    let component = EntranceMainComponents()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "UIComponent 演示"
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

class ComponentDemoComponents: PuzzleBusinessComponent {
    override func setup() {
        super.setup()
        dataSource = self
    }

    func listComponent() -> [PuzzleDisplayComponent] {
        return [
            PuzzleListComponent(viewModels: [
                SectionTitleViewModel(title: "PuzzleListDisplayComponent")
            ])
        ]
    }
}

extension ComponentDemoComponents: PuzzleBusinessComponentDatasource {
    func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleDisplayComponent] {
        var result = [PuzzleDisplayComponent]()
        result += listComponent()

        return result
    }
}
