//
//  ResponseFlights.swift
//  FlightInfoApp
//
//  Created by Sergey on 08.08.2021.
//

struct ResponseFlights: Decodable {
//    let pagination: PaginationFlights?
    let data: [Flights]?
}

//struct PaginationFlights: Decodable {
//    let limit: Int?
//    let offset: Int?
//    let count: Int?
//    let total: Int?
//}

struct Flights: Decodable {
//    let flightDate: String?
//    let flightStatus: String?
    let departure: DepartureAirport?
    let arrival: ArrivalAirport?
    let airline: Airline?
    let flight: Flight?
//    let aircraft: Aircraft?
//    let live: Live?
    init(dataFlight: [String: Any]) {
        let departureAirport = dataFlight["departure"] as? [String: Any]
        let departure = DepartureAirport(airport: departureAirport?["airport"] as? String,
                                         iata: departureAirport?["iata"] as? String,
                                         scheduled: departureAirport?["scheduled"] as? String)
        let arrivalAirport = dataFlight["arrival"] as? [String: Any]
        let arrival = ArrivalAirport(airport: arrivalAirport?["airport"] as? String,
                                     iata: arrivalAirport?["iata"] as? String,
                                     scheduled: arrivalAirport?["scheduled"] as? String)
        let airlineData = dataFlight["airline"] as? [String: Any]
        let airline = Airline(name: airlineData?["name"] as? String)
        let flightData = dataFlight["flight"] as? [String: Any]
        let flight = Flight(iata: flightData?["iata"] as? String)
        
        self.departure = departure
        self.arrival = arrival
        self.airline = airline
        self.flight = flight
    }
}

struct DepartureAirport: Decodable {
    let airport: String?
//    let timezone: String?
    let iata: String?
//    let icao: String?
//    let terminal: String?
//    let gate: String?
//    let delay: Int?
    let scheduled: String?
//    let estimated: String?
//    let actual: String?
//    let estimatedRunway: String?
//    let actualRunway: String?
}

struct ArrivalAirport: Decodable {
    let airport: String?
//    let timezone: String?
    let iata: String?
//    let icao: String?
//    let terminal: String?
//    let gate: String?
//    let baggage: String?
//    let delay:Int?
    let scheduled: String?
//    let estimated: String?
//    let actual: String?
//    let estimatedRunway: String?
//    let actualRunway: String?
}

struct Airline: Decodable {
    let name: String?
//    let iata: String?
//    let icao: String?
}

struct Flight: Decodable {
//    let number: String?
    let iata: String?
//    let icao: String?
//    let codeshared: CodesharedAirline?
}

//struct Aircraft: Decodable {
//    let registration: String?
//    let iata: String?
//    let icao: String?
//    let icao24: String?
//}

//struct Live: Decodable {
//    let updated: String?
//    let latitude: Float?
//    let longitude: Float?
//    let altitude: Float?
//    let direction: Float?
//    let speedHorizontal: Float?
//    let speedVertical: Float?
//    let isGround: Bool?
//}

//struct CodesharedAirline: Decodable {
//    let airlineName: String?
//    let airlineIata: String?
//    let airlineIcao: String?
//    let flightNumber: String?
//    let flightIata: String?
//    let flightIcao: String?
//}

enum URLS: String {
    case apiUrl = "http://api.aviationstack.com/v1/flights?access_key="
    case accessKey = "bf9f1644f60ea683c4a27c95035f65ab"
}

enum FlyghtsViewKey: String {
    case arrival = "&arr_iata="
    case diparture = "&dep_iata="
}
