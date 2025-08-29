//
//  PuzzleBaseCellModel.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2025/8/29.
//

import Foundation

/// 单元格模型的抽象基类，提供共享实现
open class PuzzleBaseCellModel: PuzzleCellModelProtocol {
    /// 关联的显示组件（弱引用避免循环引用）
    public weak var uiComponent: PuzzleDisplayComponent?
    
    /// 事件总线，用于组件间通信
    public weak var eventBus: PuzzleEventBus?
    
    /// 在集合视图中的 frame
    public var frameInCollection: CGRect?
    
    /// 浮动优先级，默认为0（不浮动）
    open var floatPriorityValue: Int { 0 }
    
    /// 获取单元格大小
    /// - Returns: 单元格的尺寸
    open func viewSize() -> CGSize {
        .zero
    }
    
    /// 创建视图类
    /// - Returns: 对应的单元格视图类型
    open func createViewClass() -> UICollectionViewCell.Type {
        UICollectionViewCell.self
    }
    
    /// 获取浮动优先级
    /// - Returns: 浮动优先级值
    public func floatPriority() -> Int {
        return floatPriorityValue
    }
    
    /// 判断是否为浮动视图
    /// - Returns: 是否浮动
    public func isFloat() -> Bool {
        floatPriority() > 0
    }
    
    /// 获取关联的适配器
    public var adapter: PuzzleCollectionViewAdapter? {
        uiComponent?.logicComponent?.adapter
    }
    
    /// 刷新视图
    public func reload(completion: @escaping (PuzzleCollectionViewAdapter.Completion)) {
        uiComponent?.logicComponent?.adapter?.reload(completion: completion)
    }
    
    /// 执行批量更新
    public func performBatchUpdate(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        uiComponent?.logicComponent?.adapter?.performBatchUpdate(updates, completion: completion)
    }
    
    public init() { }
}
