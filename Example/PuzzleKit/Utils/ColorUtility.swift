//
//  ColorUtility.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum ColorUtility {
    static func randomRGBColors(count: Int, alpha: CGFloat = 1.0) -> [UIColor] {
        guard count > 0 else { return [] }
        
        return (0..<count).map { _ in
            let red = CGFloat.random(in: 0...1)
            let green = CGFloat.random(in: 0...1)
            let blue = CGFloat.random(in: 0...1)
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}
