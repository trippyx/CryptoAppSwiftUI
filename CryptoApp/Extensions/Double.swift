//
//  Double.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import Foundation


extension Double{
    ///Convert a Double into currency
    ///```
    ///Convert 1234.5 into RS 1,234.5
    ///
    ///```
    private var currencyFormatter2:NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "INR"
        formatter.currencySymbol = "RS"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///Convert a Double into String
    ///```
    ///Convert 1234.55656 into "1234.555656"
    ///```
    func asCurrencyWith2Decimal() -> String{
        return currencyFormatter2.string(from:NSNumber(value: self)) ?? "INR0.00"
    }
    ///Convert a Double into Percentage
    ///```
    ///Convert 1234.55656 into "1234.55"
    ///```
    func asNumberString() -> String{
        return String(format: "%.2f", self)
    }
    
    func asPercantageString() -> String{
        return asNumberString() + "%"
    }
    
}
