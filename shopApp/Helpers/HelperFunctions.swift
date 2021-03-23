//
//  HelperFunctions.swift
//  shopApp
//
//  Created by Jahongir on 9/17/20.
//  Copyright © 2020 Jahongir. All rights reserved.
//

import Foundation


func converToCurrency(_ number: Double) -> String {
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale(identifier: "us_US")
    
    return currencyFormatter.string(from: NSNumber(value: number))!
}
