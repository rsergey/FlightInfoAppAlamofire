//
//  ResponseFlights.swift
//  FlightInfoApp
//
//  Created by Sergey on 08.08.2021.
//

//MARK: - ResponseFlights
struct ResponseFlights: Decodable {
    let data: [Flights]?
}

//MARK: - Flights
struct Flights: Decodable {
    let departure: DepartureAirport?
    let arrival: ArrivalAirport?
    let airline: Airline?
    let flight: Flight?
    
    init(value: [String: Any]) {
        let departureValue = value["departure"] as? [String: Any]
        departure = DepartureAirport(value: departureValue ?? [:])
        
        let arrivalValue = value["arrival"] as? [String: Any]
        arrival = ArrivalAirport(value: arrivalValue ?? [:])
        
        let airlineValue = value["airline"] as? [String: Any]
        airline = Airline(value: airlineValue ?? [:])
        
        let flightValue = value["flight"] as? [String: Any]
        flight = Flight(value: flightValue ?? [:])
    }
    
    static func getFlights(value: Any) -> [Flights] {
        guard let value = value as? [String: Any] else { return [] }
        guard let flightsData = value["data"] as? [[String: Any]] else { return [] }
        return flightsData.map { Flights(value: $0) }
    }
}

//MARK: - DepartureAirport
struct DepartureAirport: Decodable {
    let airport: String?
    let iata: String?
    let scheduled: String?
    
    init(value: [String: Any]) {
        airport = value["airport"] as? String
        iata = value["iata"] as? String
        scheduled = value["scheduled"] as? String
    }
}

//MARK: - ArrivalAirport
struct ArrivalAirport: Decodable {
    let airport: String?
    let iata: String?
    let scheduled: String?
    
    init(value: [String: Any]) {
        airport = value["airport"] as? String
        iata = value["iata"] as? String
        scheduled = value["scheduled"] as? String
    }
}

//MARK: - Airline
struct Airline: Decodable {
    let name: String?

    init(value: [String: Any]) {
        name = value["name"] as? String
    }
}

//MARK: - Flight
struct Flight: Decodable {
    let iata: String?

    init(value: [String: Any]) {
        iata = value["iata"] as? String
    }
}

//MARK: - URLS
enum URLS: String {
    case apiUrl = "http://api.aviationstack.com/v1/flights?access_key="
    case accessKey = "bf9f1644f60ea683c4a27c95035f65ab"
}

//MARK: - FlyghtsViewKey
enum FlyghtsViewKey: String {
    case arrival = "&arr_iata="
    case diparture = "&dep_iata="
}
