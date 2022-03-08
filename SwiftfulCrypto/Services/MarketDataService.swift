//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 23/02/2022.
//

import Combine
import Foundation

class MarketDataService {
  @Published var marketData: MarketData? = nil
  private var cancellable: AnyCancellable?

  init() {
    getData()
  }

  func getData() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }

    cancellable = NetworkingManager.download(url: url)
      .decode(type: GlobalData.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] globalData in
        self?.marketData = globalData.data
        self?.cancellable?.cancel()
      })
  }
}
