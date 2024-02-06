//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 06/02/24.
//

import Foundation
import Combine

class CoinDetailDataService{
    @Published var coinDetails : CoinDetailModel? = nil
    let coin : CoinModel
    var coinDetailSubsctiption:AnyCancellable?
    init(coin:CoinModel){
        self.coin = coin
        getCoinsDetail()
    }
    
     func getCoinsDetail(){
         guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id ?? "")?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubsctiption =
        NetworkingManager.download(url:url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompeltion, receiveValue: {[weak self] returnCoins in
                self?.coinDetails = returnCoins
                self?.coinDetailSubsctiption?.cancel()
            })
    }
    
}
