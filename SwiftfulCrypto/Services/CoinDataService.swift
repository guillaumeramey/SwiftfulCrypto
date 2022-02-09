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

    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { output -> Data in
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
              }
        return output.data
      }
      .receive(on: DispatchQueue.main)
      .decode(type: [Coin].self, decoder: JSONDecoder())
      .sink { completion in
        switch completion {
        case .failure(let error):
          print(error.localizedDescription)
        case .finished:
          break
        }
      } receiveValue: { [weak self] coins in
        self?.allCoins = coins
        self?.cancellable?.cancel()
      }
  }
}
