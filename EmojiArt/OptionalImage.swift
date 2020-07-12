//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Holyberry on 09.07.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
