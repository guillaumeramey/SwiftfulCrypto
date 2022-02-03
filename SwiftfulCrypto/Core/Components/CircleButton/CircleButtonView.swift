//
//  CircleButtonView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 03/02/2022.
//

import SwiftUI

struct CircleButtonView: View {
  let iconName: String

  var body: some View {
    Image(systemName: iconName)
      .foregroundColor(Color.theme.accent)
      .font(.headline)
      .frame(width: 50, height: 50)
      .background(
        Circle()
          .foregroundColor(Color.theme.background)
      )
      .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
      .padding()
  }
}

struct CircleButtonView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CircleButtonView(iconName: "heart.fill")
        .previewLayout(.sizeThatFits)

      CircleButtonView(iconName: "heart.fill")
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}
