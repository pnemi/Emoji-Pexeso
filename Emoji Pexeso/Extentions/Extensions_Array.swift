//
//  Extensions_Array.swift
//  Emoji Pexeso
//
//  Created by Petr Němeček on 10/06/2018.
//  Copyright © 2018 Petr Němeček. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle()
    {
        for _ in 0..<count
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
