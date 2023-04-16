//
//  Blogger.swift
//  FirstDemo
//
//  Created by Catherine Shing on 4/16/23.
//

import Foundation

struct Blogger {
    func makeHeadline(from input: String) -> String {

        return input.capitalized

    }
    
    func reverseString(from input: String) -> String {
        return String(input.reversed())
    }
    
    func createFile(from input: String) -> String {
        let lowerCasedInput = input.lowercased()
        let fileName = lowerCasedInput.replacingOccurrences(of: " ", with: "_")
        let filePath = NSHomeDirectory() + fileName
        return filePath
    }
}
