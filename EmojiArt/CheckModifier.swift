//
//  CheckModifier.swift
//  EmojiArt
//
//  Created by Holyberry on 15.07.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

extension View {
    func checkable(isChecked: Bool = false, checkmarkSize: CGFloat = 15) -> some View {
        return self.modifier(CheckModifier(isChecked: isChecked, checkmarkSize: checkmarkSize))
    }
}

struct CheckModifier: AnimatableModifier {
    @State var isChecked: Bool
    @State var checkmarkSize: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            if isChecked {
                ZStack(alignment: .bottomTrailing) {
                    content
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: checkmarkSize))
                }
            } else {
                content
            }
        }.onTapGesture {
            withAnimation {
                self.isChecked = !self.isChecked
            }
        }
    }
}
