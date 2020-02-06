//
//  SeatingResponse.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import Foundation
import UIKit

struct SeatingResponse : Codable {
    
    var dealOffer : [DealOffer]?
    let responseCode : String?
    let responseMessage : String?
    var seatsLower : [SeatsLower]?
    var seatsUpper : [SeatsUpper]?
    let sitingPrice : String?
    let sleeperPrice : String?
    
    enum CodingKeys: String, CodingKey {
        case dealOffer = "deal_offer"
        case responseCode = "response_code"
        case responseMessage = "response_message"
        case seatsLower = "seats_lower"
        case seatsUpper = "seats_upper"
        case sitingPrice = "siting_price"
        case sleeperPrice = "sleeper_price"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dealOffer = try values.decodeIfPresent([DealOffer].self, forKey: .dealOffer)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        seatsLower = try values.decodeIfPresent([SeatsLower].self, forKey: .seatsLower)
        seatsUpper = try values.decodeIfPresent([SeatsUpper].self, forKey: .seatsUpper)
        sitingPrice = try values.decodeIfPresent(String.self, forKey: .sitingPrice)
        sleeperPrice = try values.decodeIfPresent(String.self, forKey: .sleeperPrice)
    }
    
}
