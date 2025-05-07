import Foundation
import UIKit

struct Task: Identifiable, Codable, Equatable {
    let id: UUID
    
    var name: String
    var description: String
    var planType: String
    var addSelector: String
    var controlMethod: String
    var category: String
    var date: Date
    var time: Date
    var isCompleted: Bool = false
}


struct StringValueObject: Identifiable, Codable, Hashable {
    let id: UUID
    
    var value: String
    
    init(id: UUID = UUID(), value: String) {
        self.id = id
        
        self.value = value
    }
}


