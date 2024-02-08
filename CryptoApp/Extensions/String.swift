//
//  String.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 08/02/24.
//

import Foundation

extension String{
    var removeHTMLOccurance:String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression,range: nil)
    }
}
