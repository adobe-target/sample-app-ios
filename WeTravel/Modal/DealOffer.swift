//
//  DealOffer.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation
struct DealOffer : Codable {
    
    let dealImage : String?
    let dealName : String?
    var dealPrice : String?
    let id : String?
    var isSelected : Bool?
    enum CodingKeys: String, CodingKey {
        case dealImage = "deal_image"
        case dealName = "deal_name"
        case dealPrice = "deal_price"
        case id = "id"
        case isSelected = "isSelected"

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dealImage = try values.decodeIfPresent(String.self, forKey: .dealImage)
        dealName = try values.decodeIfPresent(String.self, forKey: .dealName)
        dealPrice = try values.decodeIfPresent(String.self, forKey: .dealPrice)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)

    }
    
}
