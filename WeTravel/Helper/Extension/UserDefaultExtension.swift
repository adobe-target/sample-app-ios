//
//  UserDefaultExtension.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation

extension UserDefaults {
    class func saveProfileInfo(name: String?, age: String?, loyality: String?)  {
        let userDefault = UserDefaults.standard
        userDefault.set(name, forKey: "name")
        userDefault.set(age, forKey: "age")
        userDefault.set(loyality, forKey: "loyality")
        userDefault.synchronize()
    }
    
    class func getProfileDetails() -> (String?, String?, String?) {
        let userDefault = UserDefaults.standard
        return (userDefault.value(forKey: "name") as? String, userDefault.value(forKey: "age") as? String, userDefault.value(forKey: "loyality") as? String)
    }
    
    class func saveSettingsInfo(launchID: String?, homeOfferRecommendation: String?, searchOfferFilter: String?, seatingDeals: String?, payments_Offers: String?)  {
        let userDefault = UserDefaults.standard
        userDefault.set(launchID, forKey: "launchID")
        userDefault.set(homeOfferRecommendation, forKey: "homeOfferRecommendation")
        userDefault.set(searchOfferFilter, forKey: "searchOfferFilter")
        userDefault.set(seatingDeals, forKey: "seatingDeals")
        userDefault.set(payments_Offers, forKey: "payments_Offers")
        userDefault.synchronize()
    }
    class func getSettingsDetails() -> (String?, String?, String?, String?, String?) {
        let userDefault = UserDefaults.standard
        return (userDefault.value(forKey: "launchID") as? String, userDefault.value(forKey: "homeOfferRecommendation") as? String, userDefault.value(forKey: "searchOfferFilter") as? String, userDefault.value(forKey: "seatingDeals") as? String, userDefault.value(forKey: "payments_Offers") as? String)
    }
}
