//
//  Recommendations.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation
struct Recommendations : Codable {
    let id : String?
    let banner : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case banner = "banner"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        banner = try values.decodeIfPresent(String.self, forKey: .banner)
    }
    
}
