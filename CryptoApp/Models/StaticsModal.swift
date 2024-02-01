//
//  StaticsModal.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 01/02/24.
//

import Foundation

struct StaticsModal : Identifiable{
    let id = UUID().uuidString
    var title:String
    var value:String
    var percentageChange:Double? = nil
    
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    
}
