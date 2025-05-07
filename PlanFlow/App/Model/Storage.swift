import SwiftUI

let TASKS_KEY = "TASKS_KEY"

class Storage {
    
    static let shared = Storage()
    
    let planTypes = ["Daily plan", "Weekly plan", "Monthly plan"]
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let weeks = ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5"]
    
    let controlMethods = ["Eisenhower", "80/20 Rule", "Two Lists"]
    
    let categoriesEisenhower = ["Important / Urgent", "Important / Not Urgent", "Unimportant / Urgent", "Unimportant / Not Urgent"]
    let categories8020 = ["Key Tasks", "Other Tasks"]
    let categoriesTwoLists = ["Current Tasks", "Long-Term Goals"]
    
    private init() {  }
    
    func save<T: Codable>(_ object: T, forKey key: String) {
        var objects = getObjects(forKey: key) as [T]
        objects.append(object)
        save(objects, forKey: key)
    }
    
    func save<T: Codable>(_ objects: [T], forKey key: String) {
        if let data = try? JSONEncoder().encode(objects) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func updateObjectById<T: Codable & Identifiable>(_ id: T.ID, with updatedObject: T, forKey key: String) {
        var objects = getObjects(forKey: key) as [T]
        if let index = objects.firstIndex(where: { $0.id == id }) {
            objects[index] = updatedObject
            save(objects, forKey: key)
        }
    }
    
    func getObjectById<T: Codable & Identifiable>(_ id: T.ID, forKey key: String) -> T? {
        let objects = getObjects(forKey: key) as [T]
        return objects.first { $0.id == id }
    }
    
    func getObjects<T: Codable>(forKey key: String) -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let objects = try? JSONDecoder().decode([T].self, from: data) else {
            return []
        }
        return objects
    }
}


