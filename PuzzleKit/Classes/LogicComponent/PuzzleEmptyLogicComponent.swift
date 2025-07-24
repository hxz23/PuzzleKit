//
//  PuzzleEmptyLogicComponent.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2022/2/17.
//

import Foundation

public class PuzzleEmptyLogicComponent: PuzzleLogicComponent, PuzzleLogicComponentDatasource {
    var height: CGFloat = 0

    public convenience init(height: CGFloat) {
        self.init()
        self.height = height
    }

    override init() {
        super.init()
        dataSource = self
    }

    public func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleAbstractUIComponent] {
        [
            PuzzleListViewComponent(
                vms: [],
                space: .none,
                contentPadding: .init(top: height, left: 0, bottom: 0, right: 0),
                decorateViewModel: nil,
                decorateViewMargin: .zero
            ),
        ]
    }
}
