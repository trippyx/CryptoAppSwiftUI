//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 29/01/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    @Published var image:UIImage? = nil
    var imageSubciption:AnyCancellable?
    let coin:CoinModel
    init(coin:CoinModel){
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage(){
        guard let url = URL(string: coin.image!) else { return }
        
       imageSubciption = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompeltion, receiveValue: {[weak self] image in
                self?.image = image
                self?.imageSubciption?.cancel()
            })
            
    }
    
    
    
}
