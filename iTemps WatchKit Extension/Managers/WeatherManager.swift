//
//  WeatherManager.swift
//  iTemps WatchKit Extension
//
//  Created by Marta on 15/8/22.
//

import Foundation
import Combine

//Publicarà els resultats després de trobar la informació a l'API del temps

/*
 Necessito la teva localització per poder mostrar-te les condicions meteorològiques
 */

final class WeatherManager: ObservableObject {
    @Published var weatherResponse = WeatherResponse(forecast: [])
    
    func getWeather(for coord: WeatherCoordinates) {
        let url = URL(string: "https://api.lil.software/weather?latitude=\(coord.lat)&longitude=\(coord.lon)")!
        NetworkManager<WeatherResponse>().fetch(for: url) { (result) in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let response):
                self.weatherResponse = response
            }
        }
    }
}
