//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Holyberry on 08.07.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    static let palette = "🗿👑🤡🔥🎱"
    
    @Published private var emojiArt = EmojiArt()
    @Published private(set) var backgroundImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] {
        return emojiArt.emojis
    }
    
    
    //MARK: - Intents
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        guard let index = emojiArt.emojis.firstIndex(matching: emoji) else { return }
        
        emojiArt.emojis[index].x += Int(offset.width)
        emojiArt.emojis[index].y += Int(offset.height)
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        guard let index = emojiArt.emojis.firstIndex(matching: emoji) else { return }
        let scaledSize = CGFloat(emojiArt.emojis[index].size) * scale
        emojiArt.emojis[index].size = Int(scaledSize.rounded(.toNearestOrEven))
    }
    
    func setBackgound(url: URL?) {
        self.emojiArt.backgroundUrl = url?.imageURL
        fetchBackgoundImageData()
    }
    
    private func fetchBackgoundImageData() {
        backgroundImage = nil
        
        guard let url =  self.emojiArt.backgroundUrl else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if url == self.emojiArt.backgroundUrl {
                        self.backgroundImage = UIImage(data: imageData)
                    }
                }
            }
        }
        
    }
}


extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(size) }
    var location: CGPoint { .init(x: CGFloat(x), y: CGFloat(y)) }
}
