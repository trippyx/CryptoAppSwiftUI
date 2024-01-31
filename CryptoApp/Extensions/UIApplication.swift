//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 31/01/24.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
