//
//  Array+Group.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2025/8/28.
//

import Foundation

extension Array {
    func group(with count: Int) -> [[Element]] {
        var result = [[Element]]()

        var sub = [Element]()
        var index = 0
        for (_, item) in enumerated() {
            index += 1
            sub.append(item)

            if index == count {
                result.append(sub)
                sub = []
                index = 0
            }
        }

        if sub.isEmpty == false {
            result.append(sub)
        }

        return result
    }
}
