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

  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
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

    portfolioDataService.$savedEntities
      .combineLatest($allCoins)
      .map(mapPortfolioCoins)
      .sink { [weak self] coins in
        self?.portfolioCoins = coins
      }
      .store(in: &cancellables)
  }

  func updatePortfolio(coin: Coin, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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

  private func mapPortfolioCoins(portfolios: [Portfolio], coins: [Coin]) -> [Coin] {
    coins.compactMap { coin in
      guard let entity = portfolios.first(where: { $0.coinId == coin.id }) else {
        return nil
      }
      return coin.updateHoldings(amount: entity.amount)
    }
  }
}
