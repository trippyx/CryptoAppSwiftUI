//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }
           
        }
    }
}
