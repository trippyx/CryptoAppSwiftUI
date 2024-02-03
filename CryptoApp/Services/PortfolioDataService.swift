//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 03/02/24.
//

import Foundation
import CoreData
class PortfolioDataService{
    private let container:NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortifolioEntity"
    @Published var savedEntities:[PortifolioEntity] = []
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error{
                print("Error loading Core Data \(error)")
            }
        }
        getPortFolio()
    }
    
    private func getPortFolio(){
        let request = NSFetchRequest<PortifolioEntity>(entityName:entityName)
        do{
           savedEntities = try container.viewContext.fetch(request)
        }catch{
            print(error)
        }
    }
    
    private func add(coin:CoinModel,amount:Double){
        let entity = PortifolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    
    func updatePortfolio(coin:CoinModel,amount:Double){
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }){
            if amount > 0{
                update(entity: entity, amount: amount )
            }else{
                delete(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
            
    }
    
    
    private func update(entity:PortifolioEntity,amount:Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity:PortifolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do{
            try container.viewContext.save()
        }catch{
            print("Could not save data \(error )")
        }
    }
    
    private func applyChanges(){
        save()
        getPortFolio()
    }
    
    
}
