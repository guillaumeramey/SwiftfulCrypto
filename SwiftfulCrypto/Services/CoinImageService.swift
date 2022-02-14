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
  private let folderName = "coin_service"
  private let imageName: String

  init(coin: Coin) {
    self.coin = coin
    imageName = coin.id
    getCoinImage()
  }

  private func getCoinImage() {
    if let savedImage = LocalFileManager.instance.getImage(imageName: imageName, folderName: folderName) {
      image = savedImage
    } else {
      downloadCoinImage()
    }
  }

  private func downloadCoinImage() {
    guard let url = URL(string: coin.image) else { return }

    cancellable = NetworkingManager.download(url: url)
      .tryMap { UIImage(data: $0) }
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
        guard let self = self, let downloadedImage = image else { return }
        self.image = downloadedImage
        self.cancellable?.cancel()
        LocalFileManager.instance.saveImage(image: downloadedImage, name: self.imageName, folder: self.folderName)
      })
  }
}
