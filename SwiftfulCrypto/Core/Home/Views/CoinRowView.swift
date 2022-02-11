//
//  CoinRowView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 07/02/2022.
//

import SwiftUI

struct CoinRowView: View {
  let coin: Coin
  let showHoldingsColumn: Bool

  var body: some View {
    HStack(spacing: 0) {
      leftColumn

      Spacer()

      if showHoldingsColumn {
        holdingsColumn
      }

      rightColumn
    }
    .font(.subheadline)
  }
}

struct CoinRowView_Previews: PreviewProvider {
  static var previews: some View {
    CoinRowView(coin: dev.coin, showHoldingsColumn: true)
      .previewLayout(.sizeThatFits)

    CoinRowView(coin: dev.coin, showHoldingsColumn: false)
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.dark)
  }
}

extension CoinRowView {
  private var leftColumn: some View {
    Group {
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .frame(minWidth: 30)

      CoinImageView(coin: coin)
        .frame(width: 30, height: 30)
        .padding(.horizontal, 5)
      
      Text(coin.symbol.uppercased())
        .font(.headline)
        .foregroundColor(Color.theme.accent)
    }
  }


  private var holdingsColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
        .bold()
        .foregroundColor(Color.theme.accent)
      Text((coin.currentHoldings ?? 0).asNumberString())
    }
    .foregroundColor(Color.theme.accent)
  }

  private var rightColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentPrice.asCurrencyWith6Decimals())
        .bold()
        .foregroundColor(Color.theme.accent)
      Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
        .foregroundColor(
          (coin.priceChangePercentage24H ?? 0) >= 0 ?
          Color.theme.green : Color.theme.red
        )
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}
