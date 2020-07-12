//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Holyberry on 08.07.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

struct EmojiArt {
    var backgroundUrl: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        var id: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    private var uniqEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqEmojiId += 1
        emojis.append(.init(text: text, x: x, y: y, size: size, id: uniqEmojiId))
    }
}



//MARK: - Codable

extension EmojiArt.Emoji: Codable {}

extension EmojiArt: Codable {
    
    init?(json: Data?) {
        guard let json = json else { return nil }
        guard let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json) else { return nil }
        
        self = newEmojiArt
    }
    
    var json: Data? {
         return try? JSONEncoder().encode(self)
     }
}
