//
//  NetworkManager.swift
//  FlightInfoApp
//
//  Created by Sergey on 10.08.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchFlights(from url: String,
                      key: String,
                      type: FlyghtsViewKey,
                      iata: String,
                      with complition: @escaping (Result<[Flights], Error>) -> Void) {
        let urlAdress = url + key + type.rawValue + iata
        guard let url = URL(string: urlAdress) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let flight = try decoder.decode(ResponseFlights.self, from: data)
                guard var flights = flight.data else { return }
                flights.sort { $0.arrival?.scheduled ?? "" < $1.arrival?.scheduled ?? "" }
                
                DispatchQueue.main.async {
                    complition(.success(flights))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchData(from url: String,
                   key: String,
                   type: FlyghtsViewKey,
                   iata: String,
                   complition: @escaping ([Flights]?, Error? ) -> Void) {
        var allFlights: [Flights] = []
        let url = url + key + type.rawValue + iata
        AF.request(url, method: .get)
            .validate()
            .responseJSON { (dataResponse) in
                switch dataResponse.result {
                case .success(let value):
                    guard let responseFlights = value as? [String: Any] else { return }
                    guard let dataFlights = responseFlights["data"] as? [[String: Any]] else { return }
                    for dataFlight in dataFlights {
                        let flights = Flights(dataFlight: dataFlight)
                        allFlights.append(flights)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        complition(nil, error)
                    }
                }
                allFlights.sort { $0.arrival?.scheduled ?? "" < $1.arrival?.scheduled ?? "" }
                DispatchQueue.main.async {
                    complition(allFlights, nil)
                }
            }
    }
    
}
