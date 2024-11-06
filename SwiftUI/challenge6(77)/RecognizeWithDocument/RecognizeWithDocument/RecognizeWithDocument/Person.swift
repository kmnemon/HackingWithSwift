//
//  Person.swift
//  RecognizeWithDocument
//
//  Created by ke on 2024/11/6.
//

import SwiftUI
import Foundation
import PhotosUI

@Observable
class Person: Identifiable, Codable {
    var id: UUID
    var name: String
    var photoData: Data
    
    var photeImage: Image? {
        if let uiImage = UIImage(data: photoData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    init(name: String, photo: Data) {
        self.id = UUID()
        self.name = name
        self.photoData = photo
    }
}
