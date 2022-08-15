//
//  NetworkManager.swift
//  iTemps WatchKit Extension
//
//  Created by Marta on 15/8/22.
//

import Foundation

//Manager genèric per poder fer crides a l'API del temps per obtenir el temps
//https://lil.software/api/ no es necessita key per l'API

final class NetworkManager<T : Codable> { //farem servir el protocol Codable
    func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            guard httpResponse.statusCode == 200 else { //tot va com la seda i hem tingut resposta
                completion(.failure(.wrongStatusCode(code: httpResponse.statusCode)))
                return
            }
            guard let data = data else { //tenim les dades
                completion(.failure(.emptyData))
                return
            }
            do {
                let json = try JSONDecoder().decode(T.self, from: data) //amb les dades que hem obtingut
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch let err {
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        } .resume() //per començar les crides
    }
}

enum NetworkError: Error {
    case badResponse
    case wrongStatusCode(code: Int)
    case error(err: String)
    case decodingError(err: String)
    case emptyData
}
