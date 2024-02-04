//
//  HomeView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    @State private var showPortfolioView = false
    @State private var changeScale = false
    @State private var showPopUp = false
    @EnvironmentObject private var vm:HomeViewModal
    var body: some View {
        ZStack(content: {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
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
                .onTapGesture {
                    HapticManager.notification(type: .success)
                    if showPortfolio{
                        showPortfolioView.toggle()
                    }
                }
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
            HStack(spacing: 4, content: {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(vm.sortOption == .rank ? 0 : 180))
                
            })
            .onTapGesture {
                withAnimation{
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio{
                HStack(spacing: 4, content: {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(.degrees(vm.sortOption == .holdings ? 0 : 180))
                })
                .onTapGesture {
                    withAnimation{
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
                
            }
            
            HStack(spacing: 4, content: {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceRevered) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(vm.sortOption == .price ? 0 : 180))
                
            })
            .onTapGesture {
                withAnimation{
                    vm.sortOption = vm.sortOption == .price ? .priceRevered : .price
                }
            }
            .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)){
                    vm.reload()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(.degrees(vm.isLoading ? 360 : 0))
        })
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
}
