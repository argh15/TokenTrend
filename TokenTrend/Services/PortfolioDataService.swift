//
//  PortfolioDataService.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioItem"
    
    @Published var savedEntities: [PortfolioItem] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error Loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - Public Methods
    func updatePortfolio(coin: Coin, amount: Double) {
        
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    // MARK: - Private Methods
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioItem>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Entities! \(error)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioItem(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioItem, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioItem) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error Saving Entities! \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
