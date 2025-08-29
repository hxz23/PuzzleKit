//
//  PuzzleView.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation
import SnapKit

public final class PuzzleView: UIView {
    public let collectionView: UICollectionView

    public let adapter = PuzzleCollectionViewAdapter()

    public init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: adapter.bridge.layout)

        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        adapter.bind(collectionView)
        collectionView.contentInset = .zero
        collectionView.contentInsetAdjustmentBehavior = .never

        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear

        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        if adapter.bridge.layout.collectionViewWidth != frame.width, frame.width > 0 {
            adapter.reload { }
        }
    }
}
