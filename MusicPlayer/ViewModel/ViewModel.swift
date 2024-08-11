//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Сергей on 10.08.2024.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var songs: [SongModel] = []
    
}
