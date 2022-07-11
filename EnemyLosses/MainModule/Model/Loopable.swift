//
//  Loopable.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 05.07.2022.
//

import Foundation

protocol Loopable {
    func allProperties() throws -> [String: Any]
}

extension Loopable {
    
    func allProperties() throws -> [String: Any] {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            throw NSError()
        }
        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }
            result[property] = value
        }
        return result
    }
}
