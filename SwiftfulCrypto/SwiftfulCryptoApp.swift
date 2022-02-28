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

  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
  }

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
