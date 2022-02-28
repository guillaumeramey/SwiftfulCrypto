//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 24/02/2022.
//

import SwiftUI

struct PortfolioView: View {
  @EnvironmentObject private var homeVM: HomeViewModel
  @Environment(\.dismiss) private var dismiss
  @State private var selectedCoin: Coin? = nil
  @State private var quantityText = ""
  @State private var showCheckmark = false

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          SearchBarView(searchText: $homeVM.searchText)
          coinLogoList

          if selectedCoin != nil {
            portfolioInput
          }
        }
        .navigationTitle("Edit Portfolio")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            dismissButton
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            saveButton
          }
      }
      }
    }
  }
}

struct PortfolioView_Previews: PreviewProvider {
  static var previews: some View {
    PortfolioView()
      .environmentObject(dev.homeVM)
  }
}

extension PortfolioView {
  private var coinLogoList: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(homeVM.allCoins) { coin in
          CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .onTapGesture {
              withAnimation(.easeIn) {
                selectedCoin = coin
              }
            }
            .background(
              RoundedRectangle(cornerRadius: 10)
                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
            )
        }
      }
      .padding(.horizontal)
      .frame(height: 120)
    }
  }

  private func getCurrentValue() -> Double {
    (Double(quantityText) ?? 0) * Double(selectedCoin?.currentPrice ?? 0)
  }

  private var portfolioInput: some View {
    VStack(spacing: 20) {
      HStack {
        Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
        Spacer()
        Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
      }

      Divider()

      HStack {
        Text("Amount in your portfolio")
        Spacer()
        TextField("Ex: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }

      Divider()

      HStack {
        Text("Current value")
        Spacer()
        Text(getCurrentValue().asCurrencyWith2Decimals())
      }
    }
    .font(.headline)
    .foregroundColor(Color.theme.accent)
    .padding()
    .animation(.none)
  }

  private var dismissButton: some View {
    Button {
      dismiss()
    } label: {
      Image(systemName: "xmark")
    }
  }

  private var saveButton: some View {
    HStack {
      Image(systemName: "checkmark")
        .foregroundColor(Color.theme.green)
        .opacity(showCheckmark ? 1 : 0)
      Button {
        saveButtonPressed()
      } label: {
        Text("SAVE")
      }
      .opacity(
        selectedCoin != nil &&
        selectedCoin?.currentHoldings != Double(quantityText) ? 1 : 0
      )
    }
    .font(.headline)
  }

  private func saveButtonPressed() {
    guard let coin = selectedCoin else { return }

    // save to portfolio

    withAnimation(.easeIn) {
      showCheckmark = true
      removeSelectedCoin()
    }

    UIApplication.shared.endEditing()

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      withAnimation(.easeOut) {
        showCheckmark = false
      }
    }
  }

  private func removeSelectedCoin() {
    selectedCoin = nil
    homeVM.searchText = ""
  }
}
