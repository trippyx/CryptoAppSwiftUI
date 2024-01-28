//
//  HomeView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack(content: {
            Color.theme.background
                .ignoresSafeArea()
            
            //Content Layer
            VStack(content: {
                homeheader
                Spacer(minLength: 0)
            })
            
            
        })
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden, for: .navigationBar)
    }
  
}


extension HomeView{
    private var homeheader : some View{
        HStack(content: {
            CircleButtonView(iconName: showPortfolio ? "plus":"info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animated: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation {
                        showPortfolio.toggle()
                    }
                }
        })
        .padding(.horizontal)
    }
}
