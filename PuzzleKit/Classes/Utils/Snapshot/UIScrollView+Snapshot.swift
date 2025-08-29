//
//  UIScrollView+Snapshot.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2024/1/5.
//

import Foundation

public extension UIScrollView {
    /// 截长屏Image
    var captureLongImage: UIImage? {
        var image: UIImage?
        let savedContentOffset = contentOffset
        let savedFrame = frame

        if savedContentOffset.y == 0 {
            contentOffset = .init(x: 0, y: 1)
        }
        contentOffset = .zero

        defer {
            contentOffset = savedContentOffset
            frame = savedFrame
        }

        layer.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)

        UIGraphicsBeginImageContext(frame.size)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: frame.size.width, height: frame.size.height), false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)

        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
