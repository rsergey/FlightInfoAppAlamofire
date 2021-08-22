//
//  NetworkManager.swift
//  FlightInfoApp
//
//  Created by Sergey on 10.08.2021.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
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
                    allFlights.append(contentsOf: Flights.getFlights(value: value))
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
