//
//  Extension_Collection.swift
//  Emoji Pexeso
//
//  Created by Petr Němeček on 10/06/2018.
//  Copyright © 2018 Petr Němeček. All rights reserved.
//

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
