//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animated:Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animated ? 1.0 : 0.0)
            .opacity(animated ? 0.0 : 1.0)
            .animation(animated ? .easeOut(duration: 1.0) : .none)
            .onAppear(perform: {
                animated.toggle()
            })
    }
}

#Preview {
    CircleButtonAnimationView(animated: .constant(false))
}
