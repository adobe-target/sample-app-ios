//
//  SearchResponse.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import Foundation

struct SearchResponse : Codable {
    
    let offers : [Offer]?
    let responseCode : String?
    let responseMessage : String?
    var travelDetails : [TravelDetails]?
    
    enum CodingKeys: String, CodingKey {
        case offers = "offers"
        case responseCode = "response_code"
        case responseMessage = "response_message"
        case travelDetails = "travel_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offers = try values.decodeIfPresent([Offer].self, forKey: .offers)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        travelDetails = try values.decodeIfPresent([TravelDetails].self, forKey: .travelDetails)
    }
    
}
