//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin:CoinModel
    let showHoldingColumn:Bool
    var body: some View {
        HStack(spacing:0,content: {
            leftColumn
            Spacer()
            if showHoldingColumn{
                centerColumn
            }
            rightColumn
        })
        .font(.subheadline)
    }
}


extension CoinRowView{
    private var leftColumn:some View{
        HStack(spacing:0,content: {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text("\(coin.symbol?.uppercased() ?? "")")
                .font(.subheadline)
                .padding(.leading,6)
                .foregroundStyle(Color.theme.accent)
        })
    }
    
    private var centerColumn:some View{
        HStack(spacing:0,content: {
            VStack(alignment:.trailing,content: {
                Text(coin.currentHoldingValue.asCurrencyWith2Decimal())
                Text((coin.currentHolding ?? 0).asNumberString())
            })
            .foregroundStyle(Color.theme.accent)
        })
    }
    
    private var rightColumn:some View{
        VStack(alignment:.trailing,content: {
            Text(coin.currentPrice.asCurrencyWith2Decimal())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text("\(coin.priceChangePercentage24H?.asPercantageString() ?? "0.0%")")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        })
        .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
    }
    
}


#Preview("Coin Row View"){
    CoinRowView(coin: DeveloperPreview.shared.coin,showHoldingColumn: true)
}
