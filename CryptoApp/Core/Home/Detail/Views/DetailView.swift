//
//  DetailView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 04/02/24.
//

import SwiftUI


struct DetailLoadingView:View {
    @Binding var coin:CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    let coin:CoinModel
    
    init(coin:CoinModel) {
        self.coin = coin
    }
    
    var body: some View {
        Text(coin.name ?? "")
      }
    }


#Preview {
    DetailLoadingView(coin:.constant(DeveloperPreview.shared.coin ))
}
