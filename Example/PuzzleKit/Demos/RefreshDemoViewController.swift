//
//  RefreshDemoViewController.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class RefreshDemoViewController: PuzzleBaseViewController {
    let component1 = RefreshComponent1()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "refresh loadmore 演示"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func logicComponents() -> [PuzzleBusinessComponent] {
        [
            component1
        ]
    }
}

class RefreshComponent1: PuzzleBusinessComponent, PuzzleBusinessComponentDatasource {
    let loadingVM = LoadingCellModel()
    var viewModels = [ListColorCellModel]()
    
    var isLoading = false
    
    override func setup() {
        super.setup()
        dataSource = self
        
        supportRefresh = true
        supportLoadMore = true
        
        refreshAction()
    }
    
    override func refreshAction() {
        super.refreshAction()
        
        isLoading = true
        adapter?.reload { }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            self.isLoading = false
            let colors = ColorUtility.randomRGBColors(count: 5)

            let news = colors.enumerated().map {
                ListColorCellModel(index: $0.offset, color: $0.element, height: 50)
            }
            
            self.viewModels = news
            self.adapter?.reload { }
            self.adapter?.endLoading(withNoData: false)
        }
    }
    
    override func loadMoreAction() {
        super.loadMoreAction()
        
        adapter?.reload { }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            let colors = ColorUtility.randomRGBColors(count: 3)

            let news = colors.enumerated().map {
                ListColorCellModel(index: $0.offset + self.viewModels.count, color: $0.element, height: 50)
            }
            
            self.viewModels += news
            
            self.adapter?.reload { }
            self.adapter?.endLoading(withNoData: false)
        }
    }

    func uiComponents(puzzleContext _: PuzzleContext) -> [PuzzleDisplayComponent] {
        var result = [PuzzleDisplayComponent]()
        
        result += [
            PuzzleListComponent(
                viewModels: [SectionTitleCellModel(title: "refresh component1 ")]
            )
        ]
        
        if isLoading {
            loadingVM.status = .loading
            result += [
                PuzzleListComponent(
                    viewModels: [loadingVM]
                )
            ]
        } else {
            result += [
                PuzzleListComponent(
                    viewModels: viewModels,
                    space: .fixed(value: 0),
                    contentPadding: .init(top: 30, left: 30, bottom: 30, right: 30),
                    decorateViewModel: .init(color: .lightGray, cornerRadius: 8)
                )
            ]
        }

        return result
    }
}
