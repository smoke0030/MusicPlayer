//
//  Model.swift
//  MusicPlayer
//
//  Created by Сергей on 09.08.2024.
//

import Foundation

struct SongModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var data: Data
    var artist: String?
    var image: Data?
    var duration: TimeInterval?
}
