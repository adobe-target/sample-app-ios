//
//  Ticket_history.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation
struct Ticket_history : Codable {
    let id : String?
    let departure : String?
    let destination : String?
    let departure_date : String?
    let departure_time : String?
    let seat : String?
    let duration : String?
    let amount : String?
    let currency_symbol : String?
    let status : String?
    let travel_name : String?
    let bus_info : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case departure = "departure"
        case destination = "destination"
        case departure_date = "departure_date"
        case departure_time = "departure_time"
        case seat = "seat"
        case duration = "duration"
        case amount = "amount"
        case currency_symbol = "currency_symbol"
        case status = "status"
        case travel_name = "travel_name"
        case bus_info = "bus_info"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        departure = try values.decodeIfPresent(String.self, forKey: .departure)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        departure_date = try values.decodeIfPresent(String.self, forKey: .departure_date)
        departure_time = try values.decodeIfPresent(String.self, forKey: .departure_time)
        seat = try values.decodeIfPresent(String.self, forKey: .seat)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        travel_name = try values.decodeIfPresent(String.self, forKey: .travel_name)
        bus_info = try values.decodeIfPresent(String.self, forKey: .bus_info)
    }
    
}
