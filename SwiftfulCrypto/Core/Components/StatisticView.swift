//
//  StatisticView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 17/02/2022.
//

import SwiftUI

struct StatisticView: View {
  let statistic: Statistic

  var body: some View {
    VStack(spacing: 4) {
      Text(statistic.title)
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)

      Text(statistic.value)
        .font(.headline)
        .foregroundColor(Color.theme.accent)

      if let percentageChange = statistic.percentageChange {
        HStack(spacing: 4) {
          Image(systemName: "triangle.fill")
            .font(.caption2)
            .rotationEffect(Angle(degrees: percentageChange >= 0 ? 0 : 180))
          Text(percentageChange.asPercentString())
            .font(.caption)
            .bold()
        }
        .foregroundColor(percentageChange >= 0 ? Color.theme.green : Color.theme.red)
      } else {
        Text("")
          .font(.caption)
          .bold()
      }
    }
  }
}

struct StatisticView_Previews: PreviewProvider {
  static var previews: some View {
    StatisticView(statistic: DeveloperPreview.instance.statistic1)
      .previewLayout(.sizeThatFits)

    StatisticView(statistic: DeveloperPreview.instance.statistic3)
      .previewLayout(.sizeThatFits)

    StatisticView(statistic: DeveloperPreview.instance.statistic2)
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.dark)
  }
}
