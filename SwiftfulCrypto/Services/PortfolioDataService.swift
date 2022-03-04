//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 04/03/2022.
//

import CoreData
import Foundation

class PortfolioDataService {
  private let container: NSPersistentContainer
  private let containerName = "PortfolioContainer"
  private let entityName = "Portfolio"

  @Published var savedEntities: [Portfolio] = []

  init() {
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading CoreData container: ", error)
        return
      }
      self.getPortfolio()
    }
  }

  // MARK: PUBLIC

  func updatePortfolio(coin: Coin, amount: Double) {
    if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
      if amount > 0 {
        update(entity: entity, amount: amount)
      } else {
        delete(entity: entity)
      }
    } else {
      add(coin: coin, amount: amount)
    }
  }

  // MARK: PRIVATE

  private func getPortfolio() {
    let request = NSFetchRequest<Portfolio>(entityName: entityName)

    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch {
      print("Error fetching Portfolio: ", error)
    }
  }

  private func add(coin: Coin, amount: Double) {
    let entity = Portfolio(context: container.viewContext)
    entity.coinId = coin.id
    entity.amount = amount
    applyChanges()
  }

  private func update(entity: Portfolio, amount: Double) {
    entity.amount = amount
    applyChanges()
  }

  private func delete(entity: Portfolio) {
    container.viewContext.delete(entity)
    applyChanges()
  }

  private func save() {
    do {
      try container.viewContext.save()
    } catch {
      print("Error saving context: ", error)
    }
  }

  private func applyChanges() {
    save()
    getPortfolio()
  }
}
