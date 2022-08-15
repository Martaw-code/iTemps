//
//  WeatherResponse.swift
//  iTemps WatchKit Extension
//
//  Created by Marta on 15/8/22.
//

import Foundation

struct WeatherResponse: Codable {
    var forecast: [WeatherModel]
}
