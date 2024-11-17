//
//  ActivityDTO.swift
//  MyFitLog
//
//  Created by Bruno Fonseca on 16/11/24.
//

import Foundation

struct ActivityDTO: Codable {
    var id: String?
    var type: String
    var duration: String
    var distance: String
    var calories: String
    var date: String
    
    init(activity: Activity) {
        self.id = activity.id
        self.type = activity.type.rawValue
        self.duration = activity.duration
        self.distance = activity.distance
        self.calories = activity.calories
        self.date = activity.date
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": self.id ?? "default_id",
            "type": self.type,
            "duration": self.duration,
            "distance": self.distance,
            "calories": self.calories,
            "date": self.date
        ]
    }
    
}


