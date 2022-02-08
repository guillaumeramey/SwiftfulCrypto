//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 02/02/2022.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
  @StateObject private var homeVM = HomeViewModel()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
      .environmentObject(homeVM)
    }
  }
}
