//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 11/02/2022.
//

import Combine
import SwiftUI

class CoinImageService {
  @Published var image: UIImage? = nil
  private var cancellable: AnyCancellable?
  private let coin: Coin

  init(coin: Coin) {
    self.coin = coin
    getCoinImage()
  }

  private func getCoinImage() {
    guard let url = URL(string: coin.image) else { return }

    cancellable = NetworkingManager.download(url: url)
      .tryMap { UIImage(data: $0) }
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
        self?.image = image
        self?.cancellable?.cancel()
      })
  }
}
