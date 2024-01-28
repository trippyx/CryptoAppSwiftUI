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
        
      coinCanlabes =  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap(\.data)
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion{
                case .finished:
                    print("Completed")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] modal in
                self?.allCoins = modal
                self?.coinCanlabes?.cancel()
            }
    }
    
}
