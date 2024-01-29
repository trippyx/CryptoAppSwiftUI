//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins : [CoinModel] = []
    var coinCanlabes:AnyCancellable?
    init(){
        getAllCoins()
    }
    
    private func getAllCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinCanlabes =
        NetworkingManager.download(url:url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompeltion, receiveValue: {[weak self] returnCoins in
                self?.allCoins = returnCoins
                self?.coinCanlabes?.cancel()
            })
    }
    
}
