//
//  CoinImageViewModal.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 29/01/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModal:ObservableObject{
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    private let coin:CoinModel
    private let dataService:CoinImageService
    var cancallbes = Set<AnyCancellable>()
    init(coin:CoinModel){
        self.coin = coin
        dataService = CoinImageService(coin: coin)
        self.isLoading = true
        addsubcriber()
    }
    
    private func addsubcriber(){
        dataService.$image.sink {[weak self]_ in
            self?.isLoading = false
        } receiveValue: {[weak self] image in
            self?.image = image
        }.store(in: &cancallbes )

    }
    
}
