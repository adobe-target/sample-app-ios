//
//  MyTicketResponse.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation
struct MyTicketResponse : Codable {
    let response_code : String?
    let response_message : String?
    var ticket_history : [Ticket_history]?
    let recommendations : [Recommendations]?
    
    enum CodingKeys: String, CodingKey {
        
        case response_code = "response_code"
        case response_message = "response_message"
        case ticket_history = "ticket_history"
        case recommendations = "recommendations"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response_code = try values.decodeIfPresent(String.self, forKey: .response_code)
        response_message = try values.decodeIfPresent(String.self, forKey: .response_message)
        ticket_history = try values.decodeIfPresent([Ticket_history].self, forKey: .ticket_history)
        recommendations = try values.decodeIfPresent([Recommendations].self, forKey: .recommendations)
    }
    
}
