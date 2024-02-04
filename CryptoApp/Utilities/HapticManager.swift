//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 04/02/24.
//

import Foundation
import SwiftUI
import UIKit
class HapticManager{
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type:UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
    
    static func generateFeedBack(){
        let impactFeedBack = UIImpactFeedbackGenerator(style: .medium)
        impactFeedBack.prepare()
        impactFeedBack.impactOccurred()
    }
    
}
