//
//  PreviewProvider.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 07/02/2022.
//

import SwiftUI

extension PreviewProvider {
  static var dev: DeveloperPreview {
    DeveloperPreview.instance
  }
}

class DeveloperPreview {
  static let instance = DeveloperPreview()
  private init() { }

  let coin = Coin(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    currentPrice: 32907,
    marketCap: 624137525042,
    marketCapRank: 1,
    fullyDilutedValuation: 691703593157,
    totalVolume: 14707671075,
    high24H: 33341,
    low24H: 31882,
    priceChange24H: 523.92,
    priceChangePercentage24H: 1.61788,
    marketCapChange24H: 6735003110,
    marketCapChangePercentage24H: 1.09086,
    circulatingSupply: 18948706,
    totalSupply: 21000000,
    maxSupply: 21000000,
    ath: 59717,
    athChangePercentage: -44.84257,
    athDate: "2021-11-10T14:24:11.849Z",
    atl: 51.3,
    atlChangePercentage: 64109.14949,
    atlDate: "2013-07-05T00:00:00.000Z",
    lastUpdated: "2022-02-04T13:45:40.631Z",
    sparklineIn7D: Coin.SparklineIn7D(price: [36483.207475402356, 36301.5145817071]),
    priceChangePercentage24HInCurrency: 1.6178787343558587,
    currentHoldings: 3)
}
