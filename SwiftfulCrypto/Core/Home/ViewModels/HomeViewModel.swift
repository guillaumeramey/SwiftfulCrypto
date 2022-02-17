//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 08/02/2022.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
  @Published var statistics: [Statistic] = [
    Statistic(title: "Title", value: "value", percentageChange: 1.23),
    Statistic(title: "Title", value: "value"),
    Statistic(title: "Title", value: "value"),
    Statistic(title: "Title", value: "value", percentageChange: -1.23)
  ]

  @Published var allCoins: [Coin] = []
  @Published var portfolioCoins: [Coin] = []
  @Published var searchText = ""

  private var dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()

  init() {
    addSubscribers()
  }

  private func addSubscribers() {
    dataService.$allCoins
      .combineLatest($searchText)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] coins in
        self?.allCoins = coins
      }
      .store(in: &cancellables)
  }

  private func filterCoins(coins: [Coin], text: String) -> [Coin] {
    guard !text.isEmpty else { return coins }

    return coins.filter { coin in
      coin.name.lowercased().contains(text.lowercased())
      || coin.symbol.lowercased().contains(text.lowercased())
      || coin.id.lowercased().contains(text.lowercased()) }
  }
}
