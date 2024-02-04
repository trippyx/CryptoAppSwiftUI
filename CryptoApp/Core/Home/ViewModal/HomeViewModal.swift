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
    @Published var isLoading = false
    @Published var sortOption:SortingOption = .holdings
    
    private let coindDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    var coinCancallbe = Set<AnyCancellable>()
    init(){
       addSubscibers()
    }
    
    enum SortingOption{
        case rank,rankReversed,holdings,holdingsReversed,price,priceRevered
    }
    
    
    func addSubscibers(){
       coindDataService.$allCoins.sink {[weak self] modal in
            print(modal)
            self?.allCoins = modal
       }.store(in: &coinCancallbe)
        
        $searchText
            .combineLatest(coindDataService.$allCoins,$sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSort)
            .sink {[weak self] filterCoinModel in
                self?.allCoins = filterCoinModel
            }.store(in: &coinCancallbe)
        
        
        $allCoins.combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModel,portEntities) -> [CoinModel] in
                
                coinModel.compactMap { (coin) -> CoinModel? in
                    guard let entity = portEntities.first(where: {$0.coinID == coin.id}) else {
                        return nil
                    }
                    return coin.updateHolding(amount:entity.amount)
                }
            }
            .sink {[weak self] retunedCoin in
                
                self?.portfolioCoins = (self?.sortPortfolioCoinsIfNeeded(coins: retunedCoin))!
            }.store(in: &coinCancallbe)
        
        
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map {[weak self] (marketDataModal,portfolio) -> [StaticsModal] in
                self!.mapGlobalData(data: marketDataModal,portfolioCoins: portfolio)
            }
            .sink {[weak self] (returnValue) in
                self?.statistics = returnValue
                self?.isLoading = false
            }.store(in: &coinCancallbe)
        

    }
    
    
    func updatePortfolio(coin:CoinModel,amount:Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterAndSort(text:String,coins:[CoinModel],sort:SortingOption) -> [CoinModel]{
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort:SortingOption,coins:inout [CoinModel]){
        switch sort {
        case .rank,.holdings:
             coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed,.holdingsReversed:
             coins.sort(by: {$0.rank > $1.rank})
        case .price:
             coins.sort(by: {$0.currentPrice < $1.currentPrice})
        case .priceRevered:
             coins.sort(by: {$0.currentPrice > $1.currentPrice})
        }
    }
    
    
    private func sortPortfolioCoinsIfNeeded(coins:[CoinModel]) -> [CoinModel]{
        switch sortOption {
       
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingValue < $1.currentHoldingValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingValue > $1.currentHoldingValue})
        default:
            return coins
        }
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
    
    func reload(){
        isLoading = true
        coindDataService.getAllCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func mapGlobalData(data:MarketDataModal?,portfolioCoins:[CoinModel]) -> [StaticsModal]{
        var stats:[StaticsModal] = []
        guard let data = data else {
            return stats
        }
        
        let portfolioValue = portfolioCoins.map { $0.currentHoldingValue }.reduce(0, +)
        
        
        let previousValue = portfolioCoins.map { coin in
            let currentValue = coin.currentHoldingValue
            let percentageChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentageChange)
            return previousValue
        }
        
        
        let previousFinalValue = previousValue.reduce(0, +)
        let percentageChange = ((portfolioValue - previousFinalValue) / previousFinalValue) * 100
        
        
        
        
        let marketCap = StaticsModal(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StaticsModal(title: "24h Volumne", value: data.volume)
        let btcDominace = StaticsModal(title: "BTC Dominace", value: data.btcDominace)
        let portfolio = StaticsModal(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimal(),percentageChange:percentageChange)
        
        
        
        stats.append(contentsOf: [marketCap,volume,btcDominace,portfolio])
        return stats
    }
    
    
    
}
