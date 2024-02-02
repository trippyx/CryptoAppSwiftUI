//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 02/02/24.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject var vm:HomeViewModal
    @State private var selectedCoin:CoinModel? = nil
    @State private var quantityText = ""
    @State private var showCheckMark = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading,spacing: 0,content: {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil{
                        portfolioInputView
                    }
                    
                })
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButtonView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingButton
                }
            })
        }
    }
    
    private func getCurrentValue() -> Double{
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModal())
}


extension PortfolioView{
    
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin else {return }
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            withAnimation(.easeIn){
                showCheckMark = false
            }
        })
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private var portfolioInputView:some View{
        VStack(spacing:20,content: {
            HStack(content: {
                Text("Current Price of \(selectedCoin?.symbol?.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimal() ?? "")
            })
            Divider()
            HStack(content: {
                Text("Amount holding :")
                Spacer()
                TextField("Ex: 1.4",text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            })
            Divider()
            HStack(content: {
                Text("Current Value")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimal())
            })
        })
        .animation(.none)
        .padding()
        .font(.headline)
    }
    private var trailingButton:some View{
        HStack(spacing:10,content: {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button(action: {
                
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(selectedCoin != nil && selectedCoin?.currentHolding != Double(quantityText) ? 1.0 : 0.0)
           
        })
        .font(.headline)
    }
    private var coinLogoList:some View{
        ScrollView(.horizontal,showsIndicators: false)  {
            LazyHStack(content: {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                }
            })
        }
        .frame(height: 120)
        .padding(.leading)
    }
}
