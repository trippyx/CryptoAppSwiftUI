//
//  Color.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
    static let launch = LaunchColor()
}


struct LaunchColor{
    let accent = Color("LaunchAccentColor")
    let backGround = Color("LaunchBackgroundColor")
}

struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
