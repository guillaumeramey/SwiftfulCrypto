//
//  HomeStatsView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 17/02/2022.
//

import SwiftUI

struct HomeStatsView: View {
  @EnvironmentObject private var homeVM: HomeViewModel
  @Binding var showPortfolio: Bool

  var body: some View {
    HStack {
      ForEach(homeVM.statistics) { statistic in
        StatisticView(statistic: statistic)
          .frame(width: UIScreen.main.bounds.width / 3)
      }
    }
    .frame(width: UIScreen.main.bounds.width,
           alignment: showPortfolio ? .trailing : .leading)
  }
}

struct HomeStatsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeStatsView(showPortfolio: .constant(false))
      .environmentObject(DeveloperPreview.instance.homeVM)
  }
}
