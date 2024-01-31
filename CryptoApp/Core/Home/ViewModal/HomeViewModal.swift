//
//  HomeViewModal.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 28/01/24.
//
import Combine
import Foundation

class HomeViewModal:ObservableObject{
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    @Published var searchText = ""
    private let dataService = CoinDataService()
    var coinCancallbe = Set<AnyCancellable>()
    init(){
       addSubscibers()
    }
    
    
    func addSubscibers(){
       dataService.$allCoins.sink {[weak self] modal in
            print(modal)
            self?.allCoins = modal
       }.store(in: &coinCancallbe)
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] filterCoinModel in
                self?.allCoins = filterCoinModel
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
    
    
}
