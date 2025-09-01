//
//  TextUtility.swift
//  PuzzleKit_Example
//
//  Created by 郝学智 on 2025/9/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class TextUtility {
    static func calculateTextHeight(_ text: String, font: UIFont, maxWidth: CGFloat) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        let constraintSize = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let boundingBox = attributedText.boundingRect(
            with: constraintSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        return ceil(boundingBox.height)
    }
}
