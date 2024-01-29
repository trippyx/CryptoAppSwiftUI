//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 29/01/24.
//

import Foundation
import Combine
class NetworkingManager{
    
    static func download(url:URL) -> AnyPublisher<Data,Error> {
     return URLSession.shared.dataTaskPublisher(for: url)
              .subscribe(on: DispatchQueue.global(qos: .default))
              .tryMap(\.data)
              .receive(on: DispatchQueue.main)
              .eraseToAnyPublisher()
    }
    
    static func handleCompeltion(completion:Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            print("Completed")
        case .failure(let error):
            print(error)
        }
    }
    
    
}
