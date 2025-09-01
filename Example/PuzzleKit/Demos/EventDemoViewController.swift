//
//  EventDemoViewController.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class EventDemoViewController: PuzzleBaseViewController {
    let component = EventComponent1()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "event 演示"
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

class EventComponent1: PuzzleBusinessComponent, PuzzleBusinessComponentDatasource {
    let receiveVM = ReceiveEventCellModel()
    let sendVM = SendEventCellModel()
    
    override func setup() {
        super.setup()
        dataSource = self
    }

    func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleDisplayComponent] {
        return [
            PuzzleListComponent(
                viewModels: [sendVM, receiveVM]
            )
        ]
    }
}
