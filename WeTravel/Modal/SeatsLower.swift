//
//  SeatsLower.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation
struct SeatsLower : Codable {
    
    let id : String?
    let price : String?
    let seatNo : String?
    let status : String?
    let type : String?
    var isSelected : Bool? = false
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case price = "price"
        case seatNo = "seat_no"
        case status = "status"
        case type = "type"
        case isSelected = "isSelected"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        seatNo = try values.decodeIfPresent(String.self, forKey: .seatNo)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)
    }
    
}
