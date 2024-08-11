//
//  BackgroundView.swift
//  MusicPlayer
//
//  Created by Сергей on 09.08.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [Color.topBackground, Color.bottomBackground],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
