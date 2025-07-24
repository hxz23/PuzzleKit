//
//  PuzzleBaseViewController.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2024/1/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

class PuzzleBaseViewController: UIViewController {
    let puzzleView = PuzzleView()

    var refreshHeader: MJRefreshHeader?

    var refreshFooter: MJRefreshFooter?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        puzzleView.adapter.reload {}
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        for logicComponent in puzzleView.adapter.logicComponents {
            if logicComponent.isAppeared == false {
                logicComponent.didAppear()
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        for logicComponent in puzzleView.adapter.logicComponents {
            if logicComponent.isAppeared {
                logicComponent.didDisappear()
            }
        }
    }

    func setupUI() {
        puzzleView.adapter.logicComponents = logicComponents()
        puzzleView.adapter.eventBus.broadcaster.register(PuzzleAdapterEvent.self, observer: self)

        view.addSubview(puzzleView)

        puzzleView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        updateSupportRefreshState()
    }

    func logicComponents() -> [PuzzleLogicComponent] {
        return []
    }

    func addRefresh() {
        let collectionView = puzzleView.collectionView

        let header = MJRefreshNormalHeader { [weak self] in
            self?.refreshAction()
            self?.puzzleView.adapter.refreshAction()
            // load some data
        }.autoChangeTransparency(true)
            .link(to: collectionView)
        header.lastUpdatedTimeLabel?.isHidden = true
        header.setTitle("下拉刷新", for: MJRefreshState.idle)
        header.setTitle("释放立即刷新", for: MJRefreshState.pulling)
        header.setTitle("刷新中...", for: MJRefreshState.refreshing)
        refreshHeader = header
    }

    func refreshAction() {}

    func removeRefresh() {
        let collectionView = puzzleView.collectionView

        collectionView.mj_header = nil
        refreshHeader = nil
    }

    func addLoadMore() {
        let collectionView = puzzleView.collectionView
        refreshFooter = MJRefreshBackNormalFooter { [weak self] in
            self?.puzzleView.adapter.loadMoreAction()
        }.autoChangeTransparency(true)
            .link(to: collectionView)
    }

    func removeLoadMore() {
        let collectionView = puzzleView.collectionView

        collectionView.mj_footer = nil
        refreshFooter = nil
    }
}

extension PuzzleBaseViewController: PuzzleAdapterEvent {
    func endLoading(withNoData: Bool) {
        if refreshHeader?.isRefreshing == true {
            refreshHeader?.endRefreshing()
        }
        if refreshFooter?.isRefreshing == true {
            refreshFooter?.endRefreshing()
        }
        if withNoData {
            refreshFooter?.endRefreshingWithNoMoreData()
        } else {
            refreshFooter?.resetNoMoreData()
        }
    }

    func updateSupportRefreshState() {
        if puzzleView.adapter.supportRefresh {
            if refreshHeader == nil {
                addRefresh()
            }
        } else {
            removeRefresh()
        }
        if puzzleView.adapter.supportLoadMore {
            if refreshFooter == nil {
                addLoadMore()
            }
        } else {
            removeLoadMore()
        }
    }

    func puzzleViewDidScroll(_: UIScrollView) {}
}
