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
    }
    
}
