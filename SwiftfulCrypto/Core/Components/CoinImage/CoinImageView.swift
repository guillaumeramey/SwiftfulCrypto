//
//  CoinImageView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 11/02/2022.
//

import SwiftUI

struct CoinImageView: View {
  @StateObject private var vm: CoinImageViewModel

  init(coin: Coin) {
    _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
  }

  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else if vm.isLoading {
        ProgressView()
      } else {
        Image(systemName: "questionmark")
          .foregroundColor(Color.theme.secondaryText)
      }
    }
  }
}

struct CoinImageView_Previews: PreviewProvider {
  static var previews: some View {
    CoinImageView(coin: DeveloperPreview.instance.coin)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
