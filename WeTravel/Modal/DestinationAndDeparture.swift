//
//  DestinationAndDeparture.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import Foundation
struct DestinationAndDeparture : Codable {
    let response_code : String?
    let response_message : String?
    let cities : [Cities]?
    
    enum CodingKeys: String, CodingKey {
        
        case response_code = "response_code"
        case response_message = "response_message"
        case cities = "cities"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response_code = try values.decodeIfPresent(String.self, forKey: .response_code)
        response_message = try values.decodeIfPresent(String.self, forKey: .response_message)
        cities = try values.decodeIfPresent([Cities].self, forKey: .cities)
    }
    
}
