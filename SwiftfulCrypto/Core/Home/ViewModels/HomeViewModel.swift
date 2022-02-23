//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 08/02/2022.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
  @Published var statistics: [Statistic] = []
  @Published var allCoins: [Coin] = []
  @Published var portfolioCoins: [Coin] = []
  @Published var searchText = ""

  private var coinDataService = CoinDataService()
  private var marketDataService = MarketDataService()
  private var cancellables = Set<AnyCancellable>()

  init() {
    addSubscribers()
  }

  private func addSubscribers() {
    coinDataService.$allCoins
      .combineLatest($searchText)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] coins in
        self?.allCoins = coins
      }
      .store(in: &cancellables)

    marketDataService.$marketData
      .map(mapGlobalMarketData)
      .sink { [weak self] statistics in
        self?.statistics = statistics
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

  private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
    guard let data = marketData else { return [] }

    let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = Statistic(title: "Volume", value: data.volume)
    let dominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
    let portfolio = Statistic(title: "Portfolio Value", value: "?", percentageChange: 0)
    
    return [marketCap, volume, dominance, portfolio]
  }
}
