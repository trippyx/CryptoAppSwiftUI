//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:UIColor(Color.theme.accent)]
    }
    
    @StateObject private var vm = HomeViewModal()
    @State private var showLaunch = true
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }
                .environmentObject(vm)
                
                ZStack(content: {
                    if showLaunch{
                        LaunchView(showLaunch: $showLaunch)
                            .transition(.move(edge: .leading))
                    }
                })
                .zIndex(2.0)
                
                
               
            }
          
        }
    }
}
