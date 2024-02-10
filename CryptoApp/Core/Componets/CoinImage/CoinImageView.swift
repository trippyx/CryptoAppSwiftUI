//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 29/01/24.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm : CoinImageViewModal
    init(coin:CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModal(coin: coin))
    }
    var body: some View {
        ZStack {
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                ProgressView()
            }else{
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
            
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.shared.coin)
}
