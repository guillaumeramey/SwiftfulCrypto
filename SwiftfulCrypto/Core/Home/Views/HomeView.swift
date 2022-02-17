//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 03/02/2022.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var homeVM: HomeViewModel
  @State private var showPortfolio = false

  var body: some View {
    ZStack {
      Color.theme.background
        .ignoresSafeArea()

      VStack {
        homeHeader

        HomeStatsView(showPortfolio: $showPortfolio)

        SearchBarView(searchText: $homeVM.searchText)

        columnTitles

        if showPortfolio {
          portfolioCoinsList
            .transition(.move(edge: .trailing))
        }

        if !showPortfolio {
          allCoinsList
            .transition(.move(edge: .leading))
        }

        Spacer(minLength: 0)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
        .navigationBarHidden(true)
    }
    .environmentObject(dev.homeVM)
  }
}

extension HomeView {
  private var homeHeader: some View {
    HStack {
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
        .animation(.none, value: showPortfolio)
        .background(
          CircleButtonAnimationView(animate: $showPortfolio)
        )

      Spacer()

      Text(showPortfolio ? "Portfolio" :"Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.theme.accent)
        .animation(.none, value: showPortfolio)

      Spacer()

      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }

  private var allCoinsList: some View {
    List {
      ForEach(homeVM.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
          .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }

  private var portfolioCoinsList: some View {
    List {
      ForEach(homeVM.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: true)
          .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }

  private var columnTitles: some View {
    HStack {
      Text("Coin")
      Spacer()
      if showPortfolio {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(Color.theme.secondaryText)
    .padding(.horizontal)
  }
}
