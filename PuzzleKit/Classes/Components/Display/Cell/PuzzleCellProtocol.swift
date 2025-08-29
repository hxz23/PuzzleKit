//
//  PuzzleCellProtocol.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public protocol PuzzleCellProtocol: AnyObject {
    func update(_ object: AnyObject)

    func willDisplay()
    
    func didEndDisplaying()

    func didSelected()
}

public extension PuzzleCellProtocol {
    func willDisplay() { }
    
    func didEndDisplaying() { }

    func didSelected() { }
}
