//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 11/02/2022.
//

import Combine
import SwiftUI

class CoinImageViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  @Published var isLoading = false

  private let coin: Coin
  private let dataService: CoinImageService
  private var cancellables = Set<AnyCancellable>()

  init(coin: Coin) {
    self.coin = coin
    dataService = CoinImageService(coin: coin)
    addSubscribers()
    isLoading = true
  }

  private func addSubscribers() {
    dataService.$image
      .sink { [weak self] _ in
        self?.isLoading = false
      } receiveValue: { [weak self] image in
        self?.image = image
      }
      .store(in: &cancellables)
  }
}
