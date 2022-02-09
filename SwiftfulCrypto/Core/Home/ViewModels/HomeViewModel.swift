//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 08/02/2022.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
  @Published var allCoins: [Coin] = []
  @Published var portfolioCoins: [Coin] = []

  private var dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()

  init() {
    addSubscribers()
  }

  private func addSubscribers() {
    dataService.$allCoins
      .sink { [weak self] coins in
        self?.allCoins = coins
      }
      .store(in: &cancellables)
  }
}
