//
//  LaunchView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 10/02/24.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText:[String] = "Loading your portfolio...".map {String($0)}
    @State private var showLoadingText = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter:Int = 0
    @State private var loops = 0
    @Binding var showLaunch:Bool
    var body: some View {
        ZStack{
            Color.launch.backGround
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack(content: {
                if showLoadingText{
                    HStack(spacing:0,content: {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launch.accent)
                                .offset(y: counter == index ? -50 : 0)
                        }
                    })
                    .transition(.scale.animation(.easeIn))
                    
                }
            })
            .offset(y: 70)
            
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring){
                let lastIndex = loadingText.count
                if counter == lastIndex{
                    loops += 1
                    if loops >= 2{
                        showLaunch = false
                    }
                    counter = 0
                }else{
                    counter += 1
                }
                
            }
        })
    }
}

#Preview {
    LaunchView(showLaunch:.constant(false))
}
