//
//  PuzeeleItemViewProtocol.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/24.
//

import Foundation

public protocol PuzzleItemViewProtocol: AnyObject {
    func update(_ object: AnyObject)
}

public protocol PuzzleItemViewDisplayProtocol: AnyObject {
    func willDisplay()
    func didEndDisplaying()
}

public protocol PuzzleItemViewDidSelectedProtocol: AnyObject {
    func didSelected()
}
