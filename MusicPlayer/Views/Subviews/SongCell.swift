//
//  SongCell.swift
//  MusicPlayer
//
//  Created by Сергей on 09.08.2024.
//

import SwiftUI

struct SongCell: View {
    
    
    //MARK: - Properties
    let song: SongModel
    
    
    //MARK: - Body
    var body: some View {
        HStack {
            Color.white
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .nameFont()
                Text(song.artist ?? "Unknown artist")
                    .artistFont()
            }
            Spacer()
            Text("duration")
                .artistFont()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}


#Preview {
    SongCell(song: SongModel(
        name: "Pain",
        data: Data(),
        artist: "Three days grace" ,
        image: Data(),
        duration: 0
    ))
}
