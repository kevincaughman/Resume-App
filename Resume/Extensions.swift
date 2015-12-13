//
//  Extensions.swift
//  Resume
//
//  Created by Kevin Caughman on 7/30/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

import Foundation

extension String {
    
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    func substring(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.advancedBy(startIndex) // Use advancedBy(int) Swift 2.0
        let returnString = self.substringToIndex(start.advancedBy(length)) // Use advancedBy(int) Swift 2.0
        print(returnString)
        return returnString
    }
    
    func contains(s: String) -> Bool {
        return (self.rangeOfString(s) != nil) ? true : false
    }
    
    func Slice(start: Int, var end: Int) -> String {
        // Keep this for negative end support
        if end < 0 {
            end = self.characters.count + end
        }
        let len = end - start; // Calculate length
        return substring(start, length: len) // Return Substring of length
    }
    
    
    func RFind(substring: String, start: Int, var end: Int) -> Int {
        
        let len = end - start
        
        if (end < 0) {
            end = self.length + end
            return self.indexOf(substring, startIndex: start)
        
        } else if (len == 0) {
            return self.lastIndexOf(substring)
        }
        return self.indexOf(substring, startIndex: start)
    }
    
    func indexOf(target: String) -> Int {
        let range = self.rangeOfString(target)
        if let range = range {
            return self.startIndex.distanceTo(range.startIndex)
        } else {
            return -1
        }
    }
    
    func indexOf(target: String, startIndex: Int) -> Int {
        let startRange = self.startIndex.advancedBy(startIndex) // Use distanceTo(int) Swift 2.0
        let range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
        if let range = range {
            return self.startIndex.distanceTo(range.startIndex) // Use distanceTo(int) Swift 2.0
        } else {
            return -1
        }
    }
    
    func lastIndexOf(target: String) -> Int {
        var index = -1
        var stepIndex = self.indexOf(target)
        
        while stepIndex > -1 {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length)
            } else {
                stepIndex = -1
            }
        }
        return index
    }
}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

