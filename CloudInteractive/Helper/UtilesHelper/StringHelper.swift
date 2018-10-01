//
//  StringHelper.swift
//  Bump
//
//  Created by Boshi Li on 2017-05-27.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

enum FontStyle: String {
    case Knewave
    case Impact
}

extension String{
    
    func url () -> URL? {
        guard self.range(of: "http") != nil else { return nil }
        guard let url = URL(string: self) else {return nil}
        return url
    }
    
    func toImageURL(_ replacementImageName: String) -> URL {
        guard let imageURL = self.url() else {
            return AssetExtractor.createLocalUrl(forImageNamed: replacementImageName)!
        }
        return imageURL
    }
    
    func toLengthOf(length:Int) -> String {
        if length <= 0 {
            return self
        } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
            return String(self[to...])
        } else {
            return ""
        }
    }
    
    mutating func removeLast(times: Int) {
        var str = self
        for _ in 0..<times {
            str = String(str.dropLast())
        }
        self = str
    }
}

// MARK: - String subscription
//someString.character(at: 10)
//someString[10...12]
//someString[10...].string
extension String {
    private func index(at offset: Int, from start: Index? = nil) -> Index? {
        return index(start ?? startIndex, offsetBy: offset, limitedBy: endIndex)
    }
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
    subscript(_ range: CountableRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: CountableClosedRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: PartialRangeUpTo<Int>) -> Substring {
        return prefix(range.upperBound)
    }
    subscript(_ range: PartialRangeThrough<Int>) -> Substring {
        return prefix(range.upperBound+1)
    }
    subscript(_ range: PartialRangeFrom<Int>) -> Substring {
        return suffix(max(0,count-range.lowerBound))
    }
}

extension Substring {
    var string: String { return String(self) }
}

extension Character {
    var string: String { return String(self) }
}
