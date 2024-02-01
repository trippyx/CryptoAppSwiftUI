//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 01/02/24.
//

import Foundation
import Combine

class MarketDataService{
    @Published var marketData : MarketDataModal? = nil
    
    var marketDataSubciption:AnyCancellable?
    
    init(){
        getData()
    }
    
    private func getData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubciption =
        NetworkingManager.download(url:url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompeltion, receiveValue: {[weak self] globalData in
                self?.marketData = globalData.data
                self?.marketDataSubciption?.cancel()
            })
    }
    
}
