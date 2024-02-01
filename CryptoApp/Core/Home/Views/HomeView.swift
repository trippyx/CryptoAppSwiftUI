//
//  HomeView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    @State private var changeScale = false
    @State private var showPopUp = false
    @EnvironmentObject private var vm:HomeViewModal
    var body: some View {
        ZStack(content: {
            Color.theme.background
                .ignoresSafeArea()
            //Content Layer
            VStack(content: {
                homeheader
                HomeStatView(showPortfolio:$showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                coloumnTiles
                if !showPortfolio{
                    allCoinList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio{
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
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
    .environmentObject(DeveloperPreview.shared.homeVM)
  
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
                .phaseAnimator([changeScale], content: { content, phase in
                    content
                        .scaleEffect(phase == false ? 1.0 : 0.7)
                        .shadow(color: phase == false ? Color.clear : .red , radius: 10, x: 0.0)
                })
                .onTapGesture {
                    withAnimation() {
                        changeScale.toggle()
                        showPortfolio.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            withAnimation {
                                changeScale.toggle()
                            }
                        })
                       
                    }
                    withAnimation(.bouncy(duration: 0.5, extraBounce: 0.5)){
                        showPopUp.toggle()
                    }
                }
        })
        .padding(.horizontal)
    }
    
    private var allCoinList:some View{
        List{
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinList:some View{
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(PlainListStyle())
    }
    
    private var coloumnTiles:some View{
        HStack(content: {
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
        })
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
}
