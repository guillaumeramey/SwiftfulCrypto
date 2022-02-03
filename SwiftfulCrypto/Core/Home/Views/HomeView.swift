//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 03/02/2022.
//

import SwiftUI

struct HomeView: View {
  @State private var showPortfolio = false

  var body: some View {
    ZStack {
      Color.theme.background
        .ignoresSafeArea()

      VStack {
        homeHeader
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
}
