//
//  kConstaints.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import Foundation
import UIKit

/// Appdalegate Object
///
/// - Returns: object
func appDelegateObject () -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

/// Loading Time Duration Set
class DispathTimeDuration {
    let kLoadingDuration = DispatchTime.now() + 3 // Sec
}

/// Currency Type Set
let currencySign = "$"
