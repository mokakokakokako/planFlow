
//
//  Conditions 2.swift
//  PlanFlow
//
//  Created by Arseniy Trishin on 09.04.2025.
//


//
//  Conditions.swift
//  PlanFlow
//
//  Created by Arseniy Trishin on 09.04.2025.
//


import Foundation
import UIKit

struct Conditions: Identifiable, Codable {
    let id: UUID
    
    var date: Date
    var time: Date
    var temperature: Double
    var humidity: Double
}

struct Pet: Identifiable, Codable {
    let id: UUID
    
    var name: String
    var type: String
    var date: Date
    
    var feeding: [Feeding] = []
    var health: [Health] = []
    var photo: UIImageData? = nil
}

struct Feeding: Identifiable, Codable {
    let id: UUID
    
    var date: Date
    var time: Date
    var food: String
    var size: String
}

struct Health: Identifiable, Codable {
    let id: UUID
    
    var date: Date
    var time: Date
    var comment: String
}

struct UIImageData: Codable {
    var imageData: Data
    
    init(from image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
    }
    
    func toUIImage() -> UIImage? {
        return UIImage(data: imageData)
    }
}

struct SO: Identifiable, Codable, Hashable {
    let id: UUID
    
    var value: String
    
    init(id: UUID = UUID(), value: String) {
        self.id = id
        
        self.value = value
    }
}

