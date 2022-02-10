//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 09/02/2022.
//

import Combine
import Foundation

class CoinDataService {
  @Published var allCoins: [Coin] = []
  private var cancellable: AnyCancellable?

  init() {
    getCoins()
  }

  private func getCoins() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }

    cancellable = NetworkingManager.download(url: url)
      .decode(type: [Coin].self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coins in
        self?.allCoins = coins
        self?.cancellable?.cancel()
      })
  }
}
