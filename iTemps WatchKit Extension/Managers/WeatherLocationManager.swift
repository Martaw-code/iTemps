//
//  WeatherLocationManager.swift
//  iTemps WatchKit Extension
//
//  Created by Marta on 15/8/22.
//

import Foundation
import CoreLocation //per trackejar la ubicació actual dels usuaris


/*
 API per la Geocodificació inversa:
 https://www.bigdatacloud.com/docs/api/free-reverse-geocode-to-city-api
 */

final class WeatherLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var cityName = "Queralbs"
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 42.350556, longitude: 2.163056)
    
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.requestAlwaysAuthorization() //preguntem a l'usuari si pot ser trackejat amb la seva ubicació(ho he afegit a info.plist
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    //obtenir els resultats de la localització
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordinate = location.coordinate
        
        //ciutat de l'usuari una vegada tenim la localització
        //endpoint: https://api.bigdatacloud.net/data/reverse-geocode
        //https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=42.348716&longitude=2.162659&localityLanguage=en
        getCityForCoordinates(location: coordinate)
    }
    
    private func getCityForCoordinates(location: CLLocationCoordinate2D) {
        let url = URL(string:"https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=\(location.latitude)&longitude=\(location.longitude)&localityLanguage=en")!
        
        NetworkManager<CityModel>().fetch(for: url) { (result) in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let cityData):
                self.cityName = "\(cityData.locality), \(cityData.countryCode)"
            }
        }
    }
}


