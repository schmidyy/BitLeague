//
//  Array+Extensions.swift
//  Plan
//
//  Created by Ozzie Kirkby on 2018-09-08.
//  Copyright © 2018 kirkbyo. All rights reserved.
//

import Foundation

extension Array {
    func chunks(ofSize size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
    
    func group(if predicate: ((Element, Element) -> Bool)) -> [[Element]] {
        guard count > 0 else { return [] }
        var array = [[Element]]()
        for index in 0 ..< count {
            let item = self[index]
            if indices.contains(index - 1) && predicate(self[index - 1], item) {
                array[array.count - 1].append(item)
            } else {
                array.append([item])
            }
        }
        
        return array
    }
}
