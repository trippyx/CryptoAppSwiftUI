//
//  HomeViewModal.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//
import Combine
import Foundation

class HomeViewModal:ObservableObject{
    
    @Published  var statistics:[StaticsModal] = []
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    @Published var searchText = ""
    private let coindDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    var coinCancallbe = Set<AnyCancellable>()
    init(){
       addSubscibers()
    }
    
    
    func addSubscibers(){
       coindDataService.$allCoins.sink {[weak self] modal in
            print(modal)
            self?.allCoins = modal
       }.store(in: &coinCancallbe)
        
        $searchText
            .combineLatest(coindDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] filterCoinModel in
                self?.allCoins = filterCoinModel
            }.store(in: &coinCancallbe)
        
        
        marketDataService.$marketData
            .map {[weak self] (marketDataModal) -> [StaticsModal] in
                self!.mapGlobalData(data: marketDataModal)
            }
            .sink {[weak self] (returnValue) in
                self?.statistics = returnValue
            }.store(in: &coinCancallbe)
        
        
    }
    
    private func filterCoins(text:String,coins:[CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercaseText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name!.lowercased().contains(lowercaseText) || coin.symbol!.lowercased().contains(lowercaseText) || coin.id!.lowercased().contains(lowercaseText)
        }
    }
    
    
    private func mapGlobalData(data:MarketDataModal?) -> [StaticsModal]{
        var stats:[StaticsModal] = []
        guard let data = data else {
            return stats
        }
        
        let marketCap = StaticsModal(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StaticsModal(title: "24h Volumne", value: data.volume)
        let btcDominace = StaticsModal(title: "BTC Dominace", value: data.btcDominace)
        let portfolio = StaticsModal(title: "Portfolio Value", value: "$0.00",percentageChange: 0)
        
        stats.append(contentsOf: [marketCap,volume,btcDominace,portfolio])
        return stats
    }
    
    
    
}
