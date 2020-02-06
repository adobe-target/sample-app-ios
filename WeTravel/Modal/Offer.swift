//
//  Offer.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import Foundation

struct Offer : Codable {
    
    let actionBanner : String?
    let flagBanner : String?
    let id : String?
    let offerBanner : String?
    let offerCode : String?
    let offerDesc : String?
    let offerName : String?
    let offerPrice : String?
    let fullOfferBanner : String?
    let tagFilter : String?

    enum CodingKeys: String, CodingKey {
        case actionBanner = "action_banner"
        case flagBanner = "flag_banner"
        case id = "id"
        case offerBanner = "offer_banner"
        case offerCode = "offer_code"
        case offerDesc = "offer_desc"
        case offerName = "offer_name"
        case offerPrice = "offer_price"
        case fullOfferBanner = "full_offer_banner"
        case tagFilter = "tag_filter"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        actionBanner = try values.decodeIfPresent(String.self, forKey: .actionBanner)
        flagBanner = try values.decodeIfPresent(String.self, forKey: .flagBanner)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        offerBanner = try values.decodeIfPresent(String.self, forKey: .offerBanner)
        offerCode = try values.decodeIfPresent(String.self, forKey: .offerCode)
        offerDesc = try values.decodeIfPresent(String.self, forKey: .offerDesc)
        offerName = try values.decodeIfPresent(String.self, forKey: .offerName)
        offerPrice = try values.decodeIfPresent(String.self, forKey: .offerPrice)
        fullOfferBanner = try values.decodeIfPresent(String.self, forKey: .fullOfferBanner)
        tagFilter = try values.decodeIfPresent(String.self, forKey: .tagFilter)

    }
    
}
