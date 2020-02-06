//
//  Cities.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import Foundation

struct Cities : Codable {
    let id : String?
    let city_code : String?
    let city_name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case city_code = "city_code"
        case city_name = "city_name"
    }
    init(id: String, city_code: String, city_name: String) {
        self.id = id
        self.city_code = city_code
        self.city_name = city_name
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
    }
    
}
