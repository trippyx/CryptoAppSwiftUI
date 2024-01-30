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
    private var imageSubciption:AnyCancellable?
    private let coin:CoinModel
    private let fileManger = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName:String
    init(coin:CoinModel){
        self.coin = coin
        self.imageName = coin.id!
        getCoinImage()
    }
    
    
    private func getCoinImage(){
        if let saved = fileManger.getImage(imageName:imageName, folderName: folderName){
            image = saved
            print("Retrived image from File Manager")
        }else{
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image!) else { return }
        
       imageSubciption = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)!
            })
            .sink(receiveCompletion: NetworkingManager.handleCompeltion, receiveValue: {[weak self] image in
                guard let self = self , let image = image else {  return  }
                self.image = image
                self.imageSubciption?.cancel()
                self.fileManger.saveImage(image: image, imageName: self.imageName, folderName: self.folderName)
            })
            
    }
    
    
    
}
