//
//  ImportFileManager.swift
//  MusicPlayer
//
//  Created by Сергей on 10.08.2024.
//

import Foundation
import SwiftUI
import AVFoundation

/// ImportFileManager - позволяет выбирать аудиофайлы и импортировать их в приложение
struct ImportFileManager: UIViewControllerRepresentable {
    
    
    @Binding var songs: [SongModel]
    
    /// Координатор управляет задачами между SwiftUi и  UiKit
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    /// Метод который создает и настраивает UIDocumentPickerViewController, который используется для выбора аудиофайлов
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        ///Разрешение открытия файлов с типом audio(MP3, WAV)
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio]) ///!!! ПРоверить работоспособность
        /// Выбор только одного файла
        picker.allowsMultipleSelection = false
        /// Показать разрешения файлов
        picker.shouldShowFileExtensions = true
        /// Установка координатора в качестве делегата
        picker.delegate = context.coordinator
        return picker
    }
    
    /// метод предназначен для обновления контроллепра с новыми данными. В данном случае он пустой, так как все необходимые  настройки выполнены при создании
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    /// Координатор служит связующим звеном между UiDocumentPicker и ImportFileManager
    class Coordinator: NSObject,  UIDocumentPickerDelegate {
        
        /// Ссылка на родительский компонент ImportFileManager, чтобы можно было с ним взаимодействоать
        var parent: ImportFileManager
        
        init(parent: ImportFileManager) {
            self.parent = parent
        }
        
        /// Этот метод вызывается когда пользователь выбирает документ(аудиофайл)
        ///  Метод обрабатывает выбранный URL и создает песню с типом SongModel и после добавляет песню в массив songs
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            
            guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            
            /// Гарантирует что доступ будет закрыть когда метод documentPicker завершится, независимо от того успешно или нет и ресурс безопасности будет закрыт и корректно освобожден из памяти
            defer { url.stopAccessingSecurityScopedResource() }
            
            do {
                /// Достаем данные по url и присваиваем константе
                let document = try Data(contentsOf: url)
                
                /// Создание  AVAsset для извлечения метаданных
                let asset = AVAsset(url: url)
                
                /// Инициализируем обьект SongModel
                var song = SongModel(name: url.lastPathComponent, data: document)
                
                /// Цикл для итерации по метаданным аудиофайла, чтобы извлечь данные.
                let metadata = asset.metadata
                for item in metadata {
                    
                    /// Проверяет есть ли метаданные у файла через ключ / значение
                    guard let key = item.commonKey?.rawValue, let value = item.value else { continue }
                    switch key {
                    case AVMetadataKey.commonKeyArtist.rawValue:
                        song.artist = value as? String
                    case AVMetadataKey.commonKeyArtwork.rawValue:
                        song.image = value as? Data
                    case AVMetadataKey.commonKeyTitle.rawValue:
                        song.name = value as? String ?? song.name
                    default:
                        break
                    }
                }
                /// Получение продолжительности песни
                song.duration = CMTimeGetSeconds(asset.duration)
                
                if !self.parent.songs.contains(where: { $0.name == song.name }) {
                    DispatchQueue.main.async {
                        self.parent.songs.append(song)
                    }
                } else {
                    print("Song with the same name already exists")
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
