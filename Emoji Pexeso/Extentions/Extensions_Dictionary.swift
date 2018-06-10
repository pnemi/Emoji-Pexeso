//
//  Extensions_Dictionary.swift
//  Emoji Pexeso
//
//  Created by Petr Němeček on 10/06/2018.
//  Copyright © 2018 Petr Němeček. All rights reserved.
//

import Foundation

extension Dictionary {
    var random: Element? {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        let key = Array(self.keys)[index]
        return (key, self[key]!)
    }
}
