//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 02/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        Color.theme.background
          .ignoresSafeArea()

        VStack {
          Text("Accent")
            .foregroundColor(Color.theme.accent)
          Text("Green")
            .foregroundColor(Color.theme.green)
          Text("Red")
            .foregroundColor(Color.theme.red)
          Text("SecondaryText")
            .foregroundColor(Color.theme.secondaryText)
        }
        .font(.title)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
