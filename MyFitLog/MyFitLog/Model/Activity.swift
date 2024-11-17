
import SwiftUI

enum ActivityType: String, CaseIterable {
    case running = "Corrida"
    case gym = "Academia"
}

class Activity: ObservableObject, Identifiable {
    @Published var id: String = UUID().uuidString
    @Published var type: ActivityType
    @Published var duration: String
    @Published var distance: String
    @Published var calories: String
    @Published var date: String
    
    init(type: ActivityType = .running, duration: String = "", calories: String = "", date: String = "", distance: String = "") {
        self.type = type
        self.duration = duration
        self.calories = calories
        self.distance = distance
        self.date = date
    }
    
    
    
    
    func isValidDate() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: date) != nil
    }
    
    func isValidDuration() -> Bool {
        guard let durationInt = Int(duration) else { return false }
        return durationInt > 0
    }
    
    func isValidDistance() -> Bool {
        if type != .running {
            return distance.isEmpty
        }
        guard let distanceFloat = Float(distance) else { return false }
        return distanceFloat > 0
    }
    
    func isValidCalories() -> Bool {
        guard let caloriesInt = Int(calories) else { return false }
        return caloriesInt > 0
    }
    
    func isValidActivity() -> Bool {
        return isValidDate() && isValidDuration() && isValidCalories() && (type != .running || isValidDistance())
    }

}
