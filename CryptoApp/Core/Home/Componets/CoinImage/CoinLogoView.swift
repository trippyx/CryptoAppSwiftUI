//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 02/02/24.
//

import SwiftUI

struct CoinLogoView: View {
    let coin:CoinModel
    var body: some View {
        VStack(content: {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.subheadline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name ?? "")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
        })
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.shared.coin)
}
