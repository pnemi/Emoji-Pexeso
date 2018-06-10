//
//  Extensions_Int.swift
//  Emoji Pexeso
//
//  Created by Petr Němeček on 10/06/2018.
//  Copyright © 2018 Petr Němeček. All rights reserved.
//

import Foundation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
