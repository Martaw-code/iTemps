//
//  WeatherModel.swift
//  iTemps WatchKit Extension
//
//  Created by Marta on 15/8/22.
//

import Foundation

struct WeatherModel: Codable {
    var name: String
    var temperature: Double
    var unit: String
    var description: String
    var conditions: String {
        switch description {
        case let str where str.lowercased().contains("Serè"):
            return "sun.max"
        case let str where str.lowercased().contains("Pluja"):
            return "cloud.rain"
        case let str where str.lowercased().contains("Sol"):
            return "sun.max"
        case let str where str.lowercased().contains("Núvol"):
            return "cloud"
        case let str where str.lowercased().contains("Neu"):
            return "cloud.snow"
        case let str where str.lowercased().contains("Boira"):
            return "cloud.fog"
        case let str where str.lowercased().contains("Tempesta"):
            return "tropicalstorm"
        default:
            return "sun.max"
        }
    }
}
