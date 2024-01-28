//
//  HomeViewModal.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import Foundation

class HomeViewModal:ObservableObject{
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.allCoins.append(DeveloperPreview.shared.coin)
            self.portfolioCoins.append(DeveloperPreview.shared.coin)
        })
    }
    
}
