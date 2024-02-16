//
//  Int+Extension.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import Foundation

extension Int {
   func createCurrencyString() -> String {
       let formatter = NumberFormatter()
       formatter.numberStyle = .currency
       formatter.locale = Locale(identifier: "en_US")
       formatter.maximumFractionDigits = 0
       return formatter.string(from: NSNumber(value: self))!
   }
}
