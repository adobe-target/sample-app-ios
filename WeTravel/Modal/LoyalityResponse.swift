//
//  LoyalityResponse.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation

struct LoyalityResponse : Codable {
    let response_code : String?
    let response_message : String?
    let loyalties : [Loyalties]?
    
    enum CodingKeys: String, CodingKey {
        
        case response_code = "response_code"
        case response_message = "response_message"
        case loyalties = "loyalties"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response_code = try values.decodeIfPresent(String.self, forKey: .response_code)
        response_message = try values.decodeIfPresent(String.self, forKey: .response_message)
        loyalties = try values.decodeIfPresent([Loyalties].self, forKey: .loyalties)
    }
    
}
