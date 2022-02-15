//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 15/02/2022.
//

import SwiftUI

struct SearchBarView: View {
  @Binding var searchText: String

  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(
          searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
        )

      TextField("Search coin", text: $searchText)
        .foregroundColor(Color.theme.accent)
        .disableAutocorrection(true)
    }
    .font(.headline)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.theme.background)
        .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
    )
    .overlay(
      Image(systemName: "xmark.circle.fill")
        .foregroundColor(Color.theme.accent)
        .padding()
        .opacity(searchText.isEmpty ? 0 : 1)
        .onTapGesture {
          UIApplication.shared.endEditing()
          searchText = ""
        },
      alignment: .trailing
    )
    .padding()
  }
}

struct SearchBarView_Previews: PreviewProvider {
  static var previews: some View {
    SearchBarView(searchText: .constant(""))
      .previewLayout(.sizeThatFits)
  }
}
