//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Сергей on 09.08.2024.
//

import SwiftUI

struct PlayerView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var showFiles = false
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                //MARK: - List of songs
                List {
                    ForEach(viewModel.songs) { song in
                        SongCell(song: song)
                    }
                }
                .listStyle(.plain)
            }
            //MARK: - Navigation Bar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showFiles.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundStyle(.white)
                    })
                }
            }
            // MARK: - Files Sheet
            .sheet(isPresented: $showFiles, content: {
                ImportFileManager(songs: $viewModel.songs)
            })
        }
    }
}

#Preview {
    PlayerView()
}

