//
//  TravelDetails.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import Foundation

struct TravelDetails : Codable {
    
    let averageRating : String?
    let busInfo : String?
    let busSets : String?
    let busStop : String?
    let countRatings : String?
    let departure : String?
    let departureTime : String?
    let destination : String?
    let id : String?
    let journeyTime : String?
    let newOperator : String?
    let offerText : String?
    let recommended : String?
    let refund : String?
    let topRatedBus : String?
    let travelName : String?
    let travelPrice : String?
    let travelWeekDay : String?
    
    enum CodingKeys: String, CodingKey {
        case averageRating = "average_rating"
        case busInfo = "bus_info"
        case busSets = "bus_sets"
        case busStop = "bus_stop"
        case countRatings = "count_ratings"
        case departure = "departure"
        case departureTime = "departure_time"
        case destination = "destination"
        case id = "id"
        case journeyTime = "journey_time"
        case newOperator = "new_operator"
        case offerText = "offer_text"
        case recommended = "recommended"
        case refund = "refund"
        case topRatedBus = "top_rated_bus"
        case travelName = "travel_name"
        case travelPrice = "travel_price"
        case travelWeekDay = "travel_week_day"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        averageRating = try values.decodeIfPresent(String.self, forKey: .averageRating)
        busInfo = try values.decodeIfPresent(String.self, forKey: .busInfo)
        busSets = try values.decodeIfPresent(String.self, forKey: .busSets)
        busStop = try values.decodeIfPresent(String.self, forKey: .busStop)
        countRatings = try values.decodeIfPresent(String.self, forKey: .countRatings)
        departure = try values.decodeIfPresent(String.self, forKey: .departure)
        departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        journeyTime = try values.decodeIfPresent(String.self, forKey: .journeyTime)
        newOperator = try values.decodeIfPresent(String.self, forKey: .newOperator)
        offerText = try values.decodeIfPresent(String.self, forKey: .offerText)
        recommended = try values.decodeIfPresent(String.self, forKey: .recommended)
        refund = try values.decodeIfPresent(String.self, forKey: .refund)
        topRatedBus = try values.decodeIfPresent(String.self, forKey: .topRatedBus)
        travelName = try values.decodeIfPresent(String.self, forKey: .travelName)
        travelPrice = try values.decodeIfPresent(String.self, forKey: .travelPrice)
        travelWeekDay = try values.decodeIfPresent(String.self, forKey: .travelWeekDay)
    }
    
}
