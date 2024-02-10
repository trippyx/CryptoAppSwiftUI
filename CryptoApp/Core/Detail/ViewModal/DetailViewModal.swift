//
//  DetailViewModal.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 06/02/24.
//

import Foundation
import Combine

class DetailViewModal:ObservableObject{
    private let coinDetailService:CoinDetailDataService
    @Published var overViewStatics : [StaticsModal] = []
    @Published var additionalStatics : [StaticsModal] = []
    @Published var coinDescription : String? =  nil
    @Published var webSiteUrl : String? = nil
    @Published var redditUrl : String? = nil
    
    var canclanble = Set<AnyCancellable>()
    @Published var coin:CoinModel
    init(coin:CoinModel){
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscibers()
    }
    
    
    func addSubscibers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapStatics)
            .sink {[weak self] returnedArray in
            self?.overViewStatics = returnedArray.overView
            self?.additionalStatics = returnedArray.additional
        }.store(in: &canclanble)
        
        
        coinDetailService.$coinDetails
            .sink {[weak self] returnedCoinDetail in
                self?.coinDescription = returnedCoinDetail?.readableDesciption
                self?.webSiteUrl = returnedCoinDetail?.links?.homepage?.first
                self?.redditUrl = returnedCoinDetail?.links?.subredditURL
            }
            .store(in: &canclanble)
        
    }
    
    
    func mapStatics(coindetailModel:CoinDetailModel?,coinModel:CoinModel) -> (overView:[StaticsModal],additional:[StaticsModal]){
        let price = coinModel.currentPrice.asCurrencyWith2Decimal()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StaticsModal(title: "Current Price", value: price,percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StaticsModal(title: "Market Capitalization", value: marketCap,percentageChange: marketCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StaticsModal(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StaticsModal(title: "Volume", value: volume)
        
        let overViewArray : [StaticsModal] = [
            priceStat,marketCapStat,rankStat,volumeStat
        ]
        
        //Additional
        let high = coinModel.high24H?.asCurrencyWith2Decimal() ?? "n/a"
        let highStat = StaticsModal(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith2Decimal() ?? "n/a"
        let lowStat = StaticsModal(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith2Decimal() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StaticsModal(title: "24h Price Change", value: priceChange,percentageChange: pricePercentChange2)
        
        let marketCapChange2 = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StaticsModal(title: "24h Market Cap Change", value: marketCapChange2, percentageChange:marketCapPercentChange2)
        
        let blockTime = coindetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StaticsModal(title: "Block Time", value: blockTimeString)
        let hashing = coindetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StaticsModal(title: "Hashing Algorithm", value: hashing)
        let additionalArray: [StaticsModal] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        return (overViewArray, additionalArray)
    }
    
}
